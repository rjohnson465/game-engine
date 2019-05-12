/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Rob the Robot";
spriteString = "npc_rob";

greeting = snd_greeting_francis;

items = ds_list_create();
var rd = instance_create_depth(x,y,1,obj_item_rubberducky);
rd.count = 3;
ds_list_add(items,rd);

wanders = false;
isFairy = false;
isFloating = false;