/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Herbie the Elf";
spriteString = "npc_elf_3";

faceSprite = spr_face_elf_3; 

defaultVendorFilter = InventoryFilters.Head;

// sells melee weapons
items = ds_list_create();
ds_list_add(items,instance_create_depth(x,y,1,obj_hat_leathercap));
ds_list_add(items,instance_create_depth(x,y,1,obj_hat_bike_helmet));
ds_list_add(items,instance_create_depth(x,y,1,obj_hat_ringed_coif));
ds_list_add(items,instance_create_depth(x,y,1,obj_hat_plated_cap));
