/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	var amount = 10*level;
	ds_map_replace(bonusesMap,MAXHP,amount);
	ds_map_replace(nextLevelBonusesMap,MAXHP,10*(level+1));
	global.player.maxHp += 10;
	isLevelingUp = false;
}