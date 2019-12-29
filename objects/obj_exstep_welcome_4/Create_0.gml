/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

messageController = "You may have two weapon sets at any time. Swap between set weapons in left / right hand using left / right on the D Pad. Try it now.";
messageMk = "You may have two weapon sets at any time. Swap between set weapons in left / right hand using Q / E. Try it now.";
promptSpritesController = [spr_prompt_xbox_pad_lr];
promptSpritesMk = [spr_prompt_mk_q, spr_prompt_mk_e];

hasCheckedInitialWeapons = false;

initWeaponR = noone;
initWeaponL = noone;