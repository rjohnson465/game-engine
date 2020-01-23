/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Ferrell the Elf";
spriteString = "npc_elf_1";

faceSprite = spr_face_elf_1; 

// sells melee weapons
items = ds_list_create();
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_longsword));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_greatsword));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_dagger));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_foil));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_spear));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_hatchet));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_battleaxe));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_warhammer));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_woodshield));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_buckler));
ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_kiteshield));