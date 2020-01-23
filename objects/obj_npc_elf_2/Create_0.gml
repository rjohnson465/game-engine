/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Alvin the Elf";
spriteString = "npc_elf_2";

faceSprite = spr_face_elf_2; 

// sells melee weapons
items = ds_list_create();
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_shortbow));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_crossbow));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_thrownknife));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_shuriken));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_pistol));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_arquebus));
