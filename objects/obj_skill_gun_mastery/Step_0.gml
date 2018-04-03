/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	ds_map_replace(bonusesMap,ModifiableProperties.WeaponTypesDamage,level*1);
	ds_map_replace(bonusesMap,ModifiableProperties.CriticalsChance,level*2);
	ds_map_replace(bonusesMap,ModifiableProperties.CriticalsDamage,level*5);
	ds_map_replace(nextLevelBonusesMap,ModifiableProperties.WeaponTypesDamage,(level+1)*1);
	ds_map_replace(nextLevelBonusesMap,ModifiableProperties.CriticalsChance,(level+1)*2);
	ds_map_replace(nextLevelBonusesMap,ModifiableProperties.CriticalsDamage,(level+1)*5);
	
	// update all blade related stats
	var bladeTypes = [PISTOL,MUSKET];
	for (var i = 0; i < array_length_1d(bladeTypes); i++) {
		var wt = bladeTypes[i];
		updatePlayerProperty(ModifiableProperties.CriticalsChance,2,0,wt);
		updatePlayerProperty(ModifiableProperties.CriticalsDamage,5,0,wt);
		updatePlayerProperty(ModifiableProperties.WeaponTypesDamage,1,0,wt);
	}
	
	isLevelingUp = false;
}