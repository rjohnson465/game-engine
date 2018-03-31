/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isLevelingUp {
	ds_map_replace(bonusesMap,DAMAGE,level*1);
	ds_map_replace(bonusesMap,CRITCHANCE,level*2);
	ds_map_replace(bonusesMap,CRITDAMAGE,level*5);
	ds_map_replace(nextLevelBonusesMap,DAMAGE,(level+1)*1);
	ds_map_replace(nextLevelBonusesMap,CRITCHANCE,(level+1)*2);
	ds_map_replace(nextLevelBonusesMap,CRITDAMAGE,(level+1)*5);
	
	// update all blade related stats
	ds_map_replace(global.player.criticalsChance,
		DAGGER,
		ds_map_find_value(global.player.criticalsChance,DAGGER)+2);
	ds_map_replace(global.player.criticalsChance,
		SWORD1H,
		ds_map_find_value(global.player.criticalsChance,SWORD1H)+2);
	ds_map_replace(global.player.criticalsChance,
		SWORD2H,
		ds_map_find_value(global.player.criticalsChance,SWORD2H)+2);
	
	ds_map_replace(global.player.criticalsDamage,
		DAGGER,
		ds_map_find_value(global.player.criticalsDamage,DAGGER)+5);
	ds_map_replace(global.player.criticalsDamage,
		SWORD1H,
		ds_map_find_value(global.player.criticalsDamage,SWORD1H)+5);
	ds_map_replace(global.player.criticalsDamage,
		SWORD2H,
		ds_map_find_value(global.player.criticalsDamage,SWORD2H)+5);
	isLevelingUp = false;
}