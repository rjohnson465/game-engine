/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	var amount = 1*level;
	ds_map_replace(bonusesMap,MAXSTAMINA,amount);
	ds_map_replace(nextLevelBonusesMap,MAXSTAMINA,1*(level+1));
	global.player.maxStamina += 1;
	isLevelingUp = false;
}