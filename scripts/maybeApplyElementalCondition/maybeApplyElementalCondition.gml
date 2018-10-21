/// maybeApplyElementalCondition(victim, damageType, damageAmount, spell, *percentChance)
/// @param damageType
/// @param damageAmount
/// @param spell -- if it exists, otherwise this will be noone
/// @param *percentChance

var damageType = argument[0];
var damageAmount = argument[1];
var spell = argument[2];
var attackObj = argument[3];

randomize();
var top = 1000;
var percentChance = .2;
if attackObj != noone && attackObj.attackData != noone {
	var condiChance = ds_map_find_value(attackObj.attackData.conditionsChances, damageType);
	if condiChance != undefined {
		percentChance = condiChance;
	}
}
//percentChance = 1;
if argument_count == 5 {
	percentChance = argument[4];
}
if spell != noone /*&& spell.name == "magicmissile"*/ {
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
var topNum = 1000-(percentChance*1000);
// only apply the condition if the condition is not currently ongoing
if rand > topNum /*&& ds_map_find_value(conditionPercentages,damageType) == 0*/ {
	
	
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
			global.conditionBarCount += 1;
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
}
// maybe play the element hit sound
if arrayIncludes(global.ALL_ELEMENTS, damageType) {
	randomize(); var rand2 = random_range(0,1);
	if rand2 < .33 || spell != noone || rand > topNum {
		var hitSnd = asset_get_index("snd_magic_"+damageType+"_hit");
		audio_play_sound_at(hitSnd,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
	}
}
