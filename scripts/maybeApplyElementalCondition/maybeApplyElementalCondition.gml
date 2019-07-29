/// maybeApplyElementalCondition(victim, damageType, damageAmount, spell, *percentChance)
/// @param damageType
/// @param damageAmount
/// @param spell -- if it exists, otherwise this will be noone
/// @param attackObj

var damageType = argument[0];
var damageAmount = argument[1];
var spell = argument[2];
var attackObj = argument[3];

// if the victim is not conditioned with this element yet, apply damage as buildup

// buildup is 0-100%, depending on the damage range the damageAmount is and victim's elemental defense, some value is added to buildup
var condiPercentageCurrent = ds_map_find_value(conditionPercentages, damageType);
if condiPercentageCurrent == 0 {
	
	var buildupAmount = 0;
	// add to buildup, based on damage range
	if damageAmount < 1 {
		buildupAmount = 10;
	}
	else if damageAmount >= 1 && damageAmount < 5 {
		buildupAmount = 25;
	}
	else if damageAmount >= 5 && damageAmount < 10 {
		buildupAmount = 33;
	}
	else if damageAmount >= 10 && damageAmount < 20 {
		buildupAmount = 50;
	}
	else if damageAmount >= 20 && damageAmount < 40 {
		buildupAmount = 75;
	} else {
		buildupAmount = 99;
	}
	// account for victim's elemental resistance 
	var resistance = ds_map_find_value(defenses, damageType); 
	var resMod = 1;
	if resistance >= 0 {
		var resMod = 1 - (resistance / 100); 
	} else {
		resMod = 1 + (abs(resistance) / 100); // negative resistance will actually increase buildup amount
	}
	buildupAmount *= resMod;
	
	// add the buildupAmount to the 
	var currentBuildup = ds_map_find_value(conditionsBuildupMap, damageType);
	
	// if current buildup is 0, create a buildup condi bar (if Player) 
	if currentBuildup == 0 && type == CombatantTypes.Player {
		global.owner = global.player.id;
		global.condition = damageType;
		instance_create_depth(x,y,1,obj_condition_bar);
	}
	
	var newBuildupAmount = currentBuildup + buildupAmount;
	ds_map_replace(conditionsBuildupMap, damageType, newBuildupAmount);
}

// else, add to the condition percentage  (maybe? is this fair? maybe not...)
// Should not do this for cold / slowed, thats BS its easy to get stuck then
/*
else if damageType != ICE {
	// condition percent is 25 to 100, based on percentOfHp the damage is
	// 0%hp hits give 25% condition bar. 20%hp hits give 100% of condition bar.
	var percentOfHp = (damageAmount/maxHp)*100;
	var condiPercent = ((15*percentOfHp)/4)+25;
	if condiPercent > 100 condiPercent = 100;
	var curVal = ds_map_find_value(conditionPercentages,damageType);
	var newVal = curVal + condiPercent;
	if newVal > 100 newVal = 100;	
	ds_map_replace(conditionPercentages,damageType,newVal);
} */

// if the buildup has gotten to 100 or more, apply condition 
var currentBuildup = ds_map_find_value(conditionsBuildupMap, damageType);
if currentBuildup >= 100 {
	// reset the buildup amount for the victim 
	ds_map_replace(conditionsBuildupMap, damageType, 0);
	
	if type == CombatantTypes.Player {
		// destroy buildup condi bar?
		var condiBuildupBar = noone;
		with obj_condition_bar {
			if condition == damageType && owner == global.player.id {
				condiBuildupBar = id;
			}
		}
		if condiBuildupBar && instance_exists(condiBuildupBar) {
			instance_destroy(condiBuildupBar);
			global.conditionBarCount--;
		}
	}
	
	if type == CombatantTypes.Player && ds_map_find_value(conditionPercentages,damageType) == 0 {
		switch damageType {
			case FIRE: {
				alert("Burning!",c_red);
				break;
			}
			case ICE: {
				alert("Frozen!",c_red);
				break;
			}
			case POISON: {
				alert("Poisoned!",c_red);
				break;
			}
			case LIGHTNING: {
				alert("Shocked!",c_red);
				break;
			}
			case MAGIC: {
				alert("Hexed!",c_red);
				break;
			}
		}
		var conditionBar = noone;
		with (obj_condition_bar) {
			if condition == damageType && owner == global.player.id {
				conditionBar = id;
			}
		}
		if !conditionBar {
			global.owner = global.player.id;
			global.condition = damageType;
			instance_create_depth(x,y,1,obj_condition_bar);
		}
	}
	
	/*
	// condition percent is 25 to 100, based on percentOfHp the damage is
	// 0%hp hits give 25% condition bar. 20%hp hits give 100% of condition bar.
	var percentOfHp = (damageAmount/maxHp)*100;
	var condiPercent = ((15*percentOfHp)/4)+25;
	if condiPercent > 100 condiPercent = 100;
	var curVal = ds_map_find_value(conditionPercentages,damageType);
	var newVal = curVal + condiPercent;
	if newVal > 100 newVal = 100;	
	ds_map_replace(conditionPercentages,damageType,newVal);
	*/
	
	// conditionPercentage is 75?
	ds_map_replace(conditionPercentages, damageType, 100);
}

/*
randomize();
var top = 1000;
var percentChance = .2;
if attackObj != noone && attackObj.attackData != noone {
	var condiChance = ds_map_find_value(attackObj.attackData.conditionsChances, damageType);
	if condiChance != undefined {
		percentChance = condiChance;
	}
}
// percentChance = 1;
if argument_count == 5 {
	percentChance = argument[4];
}
if spell != noone {
	// every misile has a 20/numProjectiles% chance
	var percentChance = (20/spell.numberOfProjectiles)/100;
	// enhance the percentChance by how much the spell was charged
	var percentCharged = attackObj.percentCharged;
	if percentCharged > .5 {
		// 50% charged gives 1.5 normal percent chance, 100% charged gives 2x normal percent chance
		var modifier = percentCharged + 1;
		percentChance *= modifier;
	}
}
var rand = random_range(1,top);
// TODO apply buffs?
var defense = ds_map_find_value(defenses,damageType);
rand -= defense;
var topNum = 1000-(percentChance*1000); */


// only apply the condition if the condition is not currently ongoing
//if rand > topNum /*&& ds_map_find_value(conditionPercentages,damageType) == 0*/ {
/*
if false {
	
	
	if type == CombatantTypes.Player && ds_map_find_value(conditionPercentages,damageType) == 0 {
		switch damageType {
			case FIRE: {
				alert("Burning!",c_red);
				break;
			}
			case ICE: {
				alert("Frozen!",c_red);
				break;
			}
			case POISON: {
				alert("Poisoned!",c_red);
				break;
			}
			case LIGHTNING: {
				alert("Shocked!",c_red);
				break;
			}
			case MAGIC: {
				alert("Hexed!",c_red);
				break;
			}
		}
		var conditionBar = noone;
		with (obj_condition_bar) {
			if condition == damageType && owner == global.player.id {
				conditionBar = id;
			}
		}
		if !conditionBar {
			global.owner = global.player.id;
			global.condition = damageType;
			instance_create_depth(x,y,1,obj_condition_bar);
		}
	}
	// condition percent is 25 to 100, based on percentOfHp the damage is
	// 0%hp hits give 25% condition bar. 20%hp hits give 100% of condition bar.
	var percentOfHp = (damageAmount/maxHp)*100;
	var condiPercent = ((15*percentOfHp)/4)+25;
	if condiPercent > 100 condiPercent = 100;
	var curVal = ds_map_find_value(conditionPercentages,damageType);
	var newVal = curVal + condiPercent;
	if newVal > 100 newVal = 100;
	ds_map_replace(conditionPercentages,damageType,newVal);
} */

// maybe play the element hit sound
if arrayIncludes(global.ALL_ELEMENTS, damageType) {
	randomize(); var rand2 = random_range(0,1);
	if rand2 < 1 || spell != noone {
		var hitSnd = asset_get_index("snd_magic_"+damageType+"_hit");
		audio_play_sound_at(hitSnd,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
	}
}
