/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if !isAlive && doSpawnTony {
	doSpawnTony = false;
	instance_create_layer(500, 500, global.player.layer, obj_npc_tony);
}