/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	var amount = 10*level;
	var nextAmount = 0;
	var bonus = 0;
	if level <= 10 {
		amount = 10*level;
		bonus = 10;
	} else if level > 10 && level <= 20 {
		amount = 100+((level-10)*5);
		bonus = 5;
	} else if level > 20 && level <= 45 {
		amount = 150+((level-20)*2);
		bonus = 2;
	} else if level > 45 {
		amount = 200+(level-45);
		bonus = 1;
	}
	
	if level <= 9 {
		nextAmount = amount + 10;
	} else if level <= 19 {
		nextAmount = amount + 5;
	} else if level <= 44 {
		nextAmount = amount + 2;
	} else nextAmount = amount + 1;
	ds_map_replace(bonusesMap,ModifiableProperties.HpMax,amount);
	ds_map_replace(nextLevelBonusesMap,ModifiableProperties.HpMax,nextAmount);
	
	updatePlayerProperty(ModifiableProperties.HpMax,bonus,0);
	
	isLevelingUp = false;
}