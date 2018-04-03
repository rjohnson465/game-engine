/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	var amount = 10*level;
	ds_map_replace(bonusesMap,ModifiableProperties.HpMax,amount);
	ds_map_replace(nextLevelBonusesMap,ModifiableProperties.HpMax,10*(level+1));
	
	updatePlayerProperty(ModifiableProperties.HpMax,10,0);
	
	isLevelingUp = false;
}