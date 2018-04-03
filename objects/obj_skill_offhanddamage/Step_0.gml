/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	ds_map_replace(bonusesMap,ModifiableProperties.OffHandDamage,5*level);
	ds_map_replace(nextLevelBonusesMap,ModifiableProperties.OffHandDamage,5*(level+1));
	
	updatePlayerProperty(ModifiableProperties.OffHandDamage,5,0);
	
	isLevelingUp = false;
}