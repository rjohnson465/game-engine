/// wishAtFountain()
// static function
	
var fountain = id;

// activate fountain
if !isRunning {
	isRunning = true;
	sprite_index = asset_get_index("spr_fountain_filling");		
	with obj_player {
		lastFountain = other.id;
		lastFountainRoom = room;
		lastFountainX = fountain.spawnX;
		lastFountainY = fountain.spawnY;
		lastFountainZ = fountain.layerName;
	}
}
	
// wish at fountain
else if isDoneFilling {
		
	// show water particles from "wish"
	randomize();
	var x1 = x + random_range(-15,15);
	var y1 = y + random_range(-15,15);

	part_emitter_region(system,emitter,x1,x1,y1,y1,0,0);
	part_emitter_burst(system,emitter,particle,num);
		
	respawnEnemies();
		
	// refill player health and stamina
	with obj_player {
		hp = maxHp;
		stamina = maxStamina;
		// cure any and all conditions
		var currentCondition = ds_map_find_first(conditionPercentages);
		for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
			ds_map_replace(conditionPercentages,currentCondition,0);
			currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
		}
		
		// refill all weapon charges for inventory weapons
		for (var i = 0 ; i < ds_list_size(inventory); i++) {
			var item = ds_list_find_value(inventory,i);
			if item.type == ItemTypes.HandItem {
				if item.totalCharges > 0 {
					item.charges = item.totalCharges;
				}
			}
		}
		
		// refill all weapon charges for equipped weapons
		for (var i = 0 ; i < ds_list_size(equippedItems); i++) {
			var item = ds_list_find_value(equippedItems,i);
			if item.type == ItemTypes.HandItem {
				if item.totalCharges > 0 {
					item.charges = item.totalCharges;
				}
			}
		}
	}
}