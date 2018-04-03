// Inherit the parent event
event_inherited();

if isLevelingUp {
	
	var range = ds_map_find_value(damageRangesByLevel,level);
	minDamage = range[0];
	maxDamage = range[1];
	
	maxChargeCost = ds_map_find_value(maxChargeCostByLevel,level);
	
	isLevelingUp = false;
}