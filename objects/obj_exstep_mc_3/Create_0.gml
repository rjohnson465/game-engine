/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

messageController = "Attack with your off hand weapon using the right bumper. Putting a weapon in your off hand makes it deal less damage. If you are using a two-handed weapon, this will use your main hand weapon.";
messageMk = "Attack with your off hand weapon using the right bumper. Putting a weapon in your off hand makes it deal less damage. If you are using a two-handed weapon, this will use your main hand weapon.";
promptSpritesController = [spr_prompt_xbox_rb];
promptSpritesMk = [spr_prompt_mk_rb];

eventListeners = ds_map_create();

hitsReceived = 0;
