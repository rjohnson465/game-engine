/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

messageController = "Explosion fires projectile(s) all around you. Leveling it up will increase the number of projectiles fired. Hold left trigger to charge a spell; release to fire. Practice shooting the enemy with ice Explosions now.";
messageMk = "Explosion fires projectile(s) all around you. Leveling it up will increase the number of projectiles fired. Hold middle mouse button to charge a spell; release to fire. Practice shooting the enemy with ice Explosions now.";
promptSpritesController = [spr_prompt_xbox_lt];
promptSpritesMk = [spr_prompt_mk_mb];

eventListeners = ds_map_create();

hitsReceived = 0;