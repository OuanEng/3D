# งานตัวละคร Animation 3D สำหรับ Godot

โปรเจกต์นี้จัดทำตามโจทย์ Blender 3D + Mixamo/Godot Animation Library โดยใช้ตัวละครแบบกล่องพื้นฐานสำหรับผู้เริ่มต้น

## สิ่งที่มีในงาน

- โมเดลจากกล่องสี่เหลี่ยม: หัว ลำตัว แขน 2 ชิ้น และขา 2 ชิ้น
- Rig แบบ Humanoid ใช้ชื่อกระดูกมาตรฐาน เช่น Root, Hips, Spine, Chest, LeftUpperArm และ LeftUpperLeg
- `BoneMaps/Mixamo BoneMap.tres`
- `Libraries/Humanoid/MeleeLib.res`
- `Libraries/Humanoid/ShooterLib.res`
- Scene Demo แสดงตัวละคร 3 ตัวพร้อมกันด้วยกล้องมุมคงที่

## วิธีเปิด

1. เปิด Godot 4
2. Import ไฟล์ `project.godot`
3. กด Run Project หรือ F6/F5
4. ตัวละครซ้าย กลาง และขวาจะแสดง Idle, Walk และ Punch พร้อมกัน

## Animation ตัวอย่าง

- Idle จาก Melee Library
- Walk จาก Melee Library
- Punch จาก Shooter Library

ไฟล์ Blender ต้นฉบับคือ `block_character_godot.blend` และไฟล์นำเข้า Godot คือ `block_character_godot.glb`
