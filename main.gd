extends Node3D

@onready var status: Label = $UI/Margin/VBox/Status
@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	camera.look_at(Vector3(0, 2.35, 0), Vector3.UP)
	var melee := load("res://Libraries/Humanoid/MeleeLib.res") as AnimationLibrary
	var shooter := load("res://Libraries/Humanoid/ShooterLib.res") as AnimationLibrary
	_setup_character($Showcase/IdleCharacter, "Demo/Melee Idle", melee, shooter)
	_setup_character($Showcase/WalkCharacter, "Demo/Melee Walk", melee, shooter)
	_setup_character($Showcase/PunchCharacter, "Demo/Punch", melee, shooter)
	status.text = "IDLE                 WALK                 PUNCH"

func _setup_character(character: Node, animation_name: String, melee: AnimationLibrary, shooter: AnimationLibrary) -> void:
	var skeletons := character.find_children("*", "Skeleton3D", true, false)
	if not skeletons.is_empty():
		var skeleton: Skeleton3D = skeletons[0]
		skeleton.name = "GeneralSkeleton"
		skeleton.unique_name_in_owner = true
	var players := character.find_children("*", "AnimationPlayer", true, false)
	if players.is_empty():
		return
	var player: AnimationPlayer = players[0]
	if player.has_animation_library(""):
		player.remove_animation_library("")
	player.add_animation_library("Melee", melee)
	player.add_animation_library("Shooter", shooter)
	_build_block_character_library(player, melee, shooter)
	player.play(animation_name)

func _build_block_character_library(player: AnimationPlayer, melee: AnimationLibrary, shooter: AnimationLibrary) -> void:
	var demo := AnimationLibrary.new()
	_add_safe_animation(demo, "Melee Idle", melee.get_animation("LightIdle"), false)
	_add_safe_animation(demo, "Melee Walk", melee.get_animation("LightWalking"), true)
	_add_safe_animation(demo, "Punch", shooter.get_animation("punch1"), false)
	player.add_animation_library("Demo", demo)

func _add_safe_animation(library: AnimationLibrary, name: String, source: Animation, moving_legs: bool) -> void:
	var animation := source.duplicate(true) as Animation
	animation.loop_mode = Animation.LOOP_LINEAR
	for track_index in range(animation.get_track_count() - 1, -1, -1):
		var path := String(animation.track_get_path(track_index))
		if (":Root" in path or ":Hips" in path or "UpperLeg" in path
			or "LowerLeg" in path or ":LeftFoot" in path or ":RightFoot" in path
			or "Toes" in path):
			animation.remove_track(track_index)
	_add_block_leg_tracks(animation, moving_legs)
	library.add_animation(name, animation)

func _add_block_leg_tracks(animation: Animation, moving: bool) -> void:
	var duration: float = maxf(animation.length, 0.5)
	var leg_paths := {
		"BlockCharacter_Rig/GeneralSkeleton/Hips_2/Leg_L": 1.0,
		"BlockCharacter_Rig/GeneralSkeleton/Hips_2/Leg_R": -1.0
	}
	for leg_path: String in leg_paths:
		var direction: float = leg_paths[leg_path]
		var track := animation.add_track(Animation.TYPE_ROTATION_3D)
		animation.track_set_path(track, NodePath(leg_path))
		if moving:
			animation.rotation_track_insert_key(track, 0.0, Quaternion(Vector3.RIGHT, deg_to_rad(16.0 * direction)))
			animation.rotation_track_insert_key(track, duration * 0.5, Quaternion(Vector3.RIGHT, deg_to_rad(-16.0 * direction)))
			animation.rotation_track_insert_key(track, duration, Quaternion(Vector3.RIGHT, deg_to_rad(16.0 * direction)))
		else:
			animation.rotation_track_insert_key(track, 0.0, Quaternion.IDENTITY)
			animation.rotation_track_insert_key(track, duration, Quaternion.IDENTITY)
