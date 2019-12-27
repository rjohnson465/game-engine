/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

messageController = "Attack with your main hand weapon using the left bumper";
messageMk = "Attack with your left hand weapon using the left mouse button";
promptSpritesController = [spr_prompt_xbox_lb];
promptSpritesMk = [spr_prompt_mk_lb];

eventListeners = ds_map_create();

hitsReceived = 0;
