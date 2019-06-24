/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	var amount = 0;
	var nextAmount = 0;
	var bonus = 0;
	if level <= 3 {
		amount = 3*level;
		bonus = 3;
	}
	else if level > 3 && level <= 7 {
		amount = 9+(2*(level-3));
		bonus = 2;
	} else {
		amount = 16+((level-6));
		bonus = 1;
	}
	
	if level <= 2 {
		nextAmount = amount + 3;
	} else if level > 2 && level <=6 {
		nextAmount = amount+2;
	} else nextAmount = amount+1;
	ds_map_replace(bonusesMap,ModifiableProperties.PoiseMax,amount);
	ds_map_replace(nextLevelBonusesMap,ModifiableProperties.PoiseMax,nextAmount);
	
	// updatePlayerProperty(ModifiableProperties.Poise,bonus,0);
	updatePlayerProperty(ModifiableProperties.PoiseMax,bonus,0);
	
	isLevelingUp = false;
}