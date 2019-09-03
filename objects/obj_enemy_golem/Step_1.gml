/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var rmap = ds_map_create();
	ds_map_replace(rmap,ItemRarities.Normal,85);
	ds_map_replace(rmap,ItemRarities.Fine,12);
	ds_map_replace(rmap,ItemRarities.Masterwork,3);
	ds_map_replace(rmap,ItemRarities.Legendary,0);

	var item1 = maybeMakeItem(0,rmap); //randomly generated item
	var map2 = ds_map_create();
	ds_map_add(map2, obj_item_jalapeno, 5);
	var item2 = maybeMakeItemBasic(map2, .05);
	var gold = makeGold(0,0);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1, item2);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	ds_map_destroy(map2); map2 = -1;
	
	// generate dybukk
	var fd = facingDirection;
	var dybukk = instance_create_layer(x,y,layer,obj_enemy_dybukk);
	with dybukk {
		doesEnemyRespawn = false;
		populatePersonalGrid();
		facingDirection = fd;
		attackFrequencyTotalFramesMeleeDefault = attackFrequencyTotalFramesMelee;
		attackFrequencyTotalFramesRangedDefault = attackFrequencyTotalFramesRanged;
		
		// since this is a dynamically added enemy, we must manually add it to the room data
		with obj_room_data {
			ds_map_add_map(enemiesData, other.key, other.persistentProperties);
			var map = ds_map_find_value(enemiesData, other.key);
			// hp and maxHp init values must be recorded here, otherwise they're always 35 
			// since thats the default base enemy class values, and persistentProperties map is 
			// populated at the end of the Create Event of the base enemy class
			ds_map_replace(map, "Hp", other.hp);
			ds_map_replace(map, "MaxHp", other.maxHp); 
			ds_map_replace(map, "CurrentZ", other.layer);
			ds_map_replace(map, "DoesEnemyRespawn", false);
		}
		
	}
}

// Inherit the parent event
event_inherited();