/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "The Elder, Barry";
spriteString = "npc_barry";

greeting = snd_greeting_francis;

items = ds_list_create();
var aqs = makeGem(obj_gem_aquamarine,CRACKED);
aqs.count = 3;
ds_list_add(items,aqs);

ds_list_add(items,instance_create_depth(x,y,1,obj_hand_item_battleaxe));