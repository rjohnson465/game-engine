/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Robort";
spriteString = "npc_rob";

greeting = [snd_npc_rob_greeting_1, snd_npc_rob_greeting_2];

items = ds_list_create();
var rd = instance_create_depth(x,y,1,obj_item_rubberducky);
rd.count = 3;
ds_list_add(items,rd);

defaultVendorFilter = InventoryFilters.Other;

wanders = false;
isFairy = false;
isFloating = false;

faceSprite = spr_face_robort;