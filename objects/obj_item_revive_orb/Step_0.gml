/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	global.player.hp = global.player.maxHp;
	global.player.stamina = global.player.maxStamina;
	isInUse = false;
}