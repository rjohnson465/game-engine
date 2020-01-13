/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

messageController = "Blast is a powerful, single projectile spell. Hold left trigger to charge a spell; release to fire. Practice shooting the enemy with poison Blasts now.";
messageMk = "Blast is a powerful, single projectile spell. Hold middle mouse button to charge a spell; release to fire. Practice shooting the enemy with poison Blasts now.";
promptSpritesController = [spr_prompt_xbox_lt];
promptSpritesMk = [spr_prompt_mk_mb];

eventListeners = ds_map_create();

hitsReceived = 0;