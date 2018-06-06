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
	
	// trigger a save 
	with obj_game_manager {
		alert("Saving " + currentSaveFile, c_yellow);
		other.fountainData.isDoneFilling = true;
		fs_save_game();
	}
}
	
// wish at fountain
else if isDoneFilling {
		
	// show water particles from "wish"
	/*randomize();
	var x1 = x + random_range(-15,15);
	var y1 = y + random_range(-15,15);

	part_emitter_region(system,emitter,x1,x1,y1,y1,0,0);
	part_emitter_burst(system,emitter,particle,num);*/
	
	// despawn all itemDrops
	with obj_item_drop {
		instance_destroy(id,1);
	}
	// clear all itemDrop references in room persistence objects
	with obj_room_data {
		ds_list_clear(itemDropsData);
	}
	// destroy any remaining itemdrop data objects
	with obj_itemdrop_data {
		instance_destroy(id,1);
	}
	
	// respawn all enemies
	respawnEnemies();
		
	// refill player health and stamina
	with obj_player {
		hp = maxHp;
		stamina = maxStamina;
		
		// convert temp xp to real xp
		xp += xpTemp;
		xpTemp = 0;
		
		// cure any and all conditions
		var currentCondition = ds_map_find_first(conditionPercentages);
		for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
			ds_map_replace(conditionPercentages,currentCondition,0);
			currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
		}
		
		// refill all weapon charges / durability for inventory weapons, repair all durability
		for (var i = 0 ; i < ds_list_size(inventory); i++) {
			var item = ds_list_find_value(inventory,i);
			if item.type == ItemTypes.HandItem {
				if item.chargesMax > 0 {
					item.charges = item.chargesMax;
				}
				if item.durability > 0 {
					item.durability = item.durabilityMax;
				}
				item.hasIssuedDurabilityWarning = false;
				item.hasIssuedDurabilityObituary = false;
				item.ammo = item.ammoMax;

			}
		}
	}
}