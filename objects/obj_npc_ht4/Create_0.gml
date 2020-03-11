 /// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Liron";
spriteString = "npc_ht4";

faceSprite = spr_face_elf_1; 

defaultVendorFilter = InventoryFilters.Other;
items = ds_list_create();
ds_list_add(items,instance_create_depth(x,y,1,obj_item_ancient_coin));
ds_list_add(items,instance_create_depth(x,y,1,obj_item_blessing));
ds_list_add(items,instance_create_depth(x,y,1,obj_item_jalapeno));