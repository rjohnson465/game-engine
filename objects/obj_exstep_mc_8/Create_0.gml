/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

messageController = "When a shield is equipped, block with the right bumper. Shields absorb some (or all) of incoming damage, depending on the shield and its properties. Practice blocking enemy attacks now.";
messageMk = "When a shield is equipped, block with the right bumper. Shields absorb some (or all) of incoming damage, depending on the shield and its properties. Practice blocking enemy attacks now.";
promptSpritesController = [spr_prompt_xbox_rb];
promptSpritesMk = [spr_prompt_mk_rb];

blocksPerformed = 0;

hasActivatedEnemy = false;

eventListeners = ds_map_create();