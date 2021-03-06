 /// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Moishe";
spriteString = "npc_ht3";

faceSprite = spr_face_elf_1; 


items = ds_list_create();
ds_list_add(items,instance_create_depth(x,y,1,obj_item_jalapeno));
ds_list_add(items,instance_create_depth(x,y,1,obj_item_icecube));
ds_list_add(items,instance_create_depth(x,y,1,obj_item_club_soda));
ds_list_add(items,instance_create_depth(x,y,1,obj_item_razorade));
ds_list_add(items,instance_create_depth(x,y,1,obj_item_spearmint_elixir));
ds_list_add(items,makeGemPieces(obj_gempieces_ruby, GRAINS));
ds_list_add(items,makeGemPieces(obj_gempieces_emerald, GRAINS));

defaultVendorFilter = InventoryFilters.Other;