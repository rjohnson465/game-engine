/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

messageController = "Switch your current element by holding right trigger and using the D pad left / right buttons. Switch your current element to lightning (purple).";
messageMk = "To switch your current element, click on an element above your belt, or press the corresponding function key. Switch to the lightning (purple) element now.";
promptSpritesController = [spr_prompt_xbox_rt, spr_prompt_xbox_pad_lr];
promptSpritesMk = [spr_prompt_mk_lb, spr_prompt_mk_f1, spr_prompt_mk_f2, spr_prompt_mk_f3, spr_prompt_mk_f4, spr_prompt_mk_f5];

eventListeners = ds_map_create();

hitsReceived = 0;