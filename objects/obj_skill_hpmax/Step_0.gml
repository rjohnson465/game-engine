/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	var amount = 10*level;
	var nextAmount = 0;
	var bonus = 0;
	
	var tier1Bonus = 5; // levels 1-10
	var tier2Bonus = 3; // levels 11-20
	var tier3Bonus = 2; // levels 20-45
	var tier4Bonus = 1; // levels 45-99
	
	if level <= 10 {
		bonus = tier1Bonus;
		amount = tier1Bonus*level;
	} else if level > 10 && level <= 20 {
		bonus = tier2Bonus;
		amount = (tier1Bonus*10)+((level-10)*tier2Bonus);
	} else if level > 20 && level <= 45 {
		bonus = tier3Bonus;
		amount = (tier1Bonus*10) + (tier2Bonus*10) +((level-20)*tier3Bonus);
	} else if level > 45 {
		bonus = tier4Bonus;
		amount = 200+(level-45);
	}
	
	if level <= 9 {
		nextAmount = amount + tier1Bonus;
	} else if level <= 19 {
		nextAmount = amount + tier2Bonus;
	} else if level <= 44 {
		nextAmount = amount + tier3Bonus;
	} else nextAmount = amount + tier4Bonus;
	ds_map_replace(bonusesMap,ModifiableProperties.HpMax,amount);
	ds_map_replace(nextLevelBonusesMap,ModifiableProperties.HpMax,nextAmount);
	
	updatePlayerProperty(ModifiableProperties.HpMax,bonus,0);
	
	with obj_player {
		hp = maxHp;
	}
	
	isLevelingUp = false;
}