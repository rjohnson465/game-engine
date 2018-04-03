/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	var amount = 1*level;
	ds_map_replace(bonusesMap,ModifiableProperties.StaminaMax,amount);
	ds_map_replace(nextLevelBonusesMap,ModifiableProperties.StaminaMax,1*(level+1));
	
	updatePlayerProperty(ModifiableProperties.StaminaMax,1,0);
	
	isLevelingUp = false;
}