/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	var base = ds_map_find_value(global.player.propertiesBaseValues,ModifiableProperties.OffHandDamage);
	ds_map_replace(bonusesMap,ModifiableProperties.OffHandDamage,base+(5*level));
	ds_map_replace(nextLevelBonusesMap,ModifiableProperties.OffHandDamage,base+(5*(level+1)));
	
	updatePlayerProperty(ModifiableProperties.OffHandDamage,5,0);
	
	isLevelingUp = false;
}