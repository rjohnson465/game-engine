if room == roomIndex {
	// set all fountains
	for (var i = 0; i < ds_list_size(fountainsData); i++) {
		var fountainData = ds_list_find_value(fountainsData,i);
		var fountain = findPersistentRoomElement(obj_fountain,fountainData.postX,fountainData.postY);
		
		if fountainData.isDoneFilling {
			fountain.isDoneFilling = false;
			fountain.isRunning = true;
		}
		fountain.fountainData = fountainData;
	}
	
	// set all enemies 
	/*for (var i = 0; i < ds_list_size(enemiesData); i++) {
		var enemyData = ds_list_find_value(enemiesData,i);
		var enemy = findPersistentRoomElement(obj_enemy_parent,enemyData.postX,enemyData.postY);
		
		enemy.hp = enemyData.hp;
		enemy.x = enemyData.currentX;
		enemy.y = enemyData.currentY;
		enemy.layer = enemyData.currentZ;
		enemy.isAlive = enemyData.isAlive;
		enemy.tempPostX = enemyData.tempPostX;
		enemy.tempPostY = enemyData.tempPostY;
		enemy.enemyData = enemyData;
	}*/
	
	// set all itemDrops
	/*
	for (var i = 0; i < ds_list_size(itemDropsData); i++) {
		var itemDropDataObj = ds_list_find_value(itemDropsData,i);
		if itemDropDataObj == undefined || itemDropDataObj == noone || !itemDropDataObj break;
		var itemDrop = findPersistentRoomElement(obj_item_drop,itemDropDataObj.postX,itemDropDataObj.postY);
		if !itemDrop || itemDrop == noone break;
		
		itemDrop.itemDropData = itemDropDataObj;
		itemDrop.x = itemDropDataObj.postX;
		itemDrop.y = itemDropDataObj.postY;
		itemDrop.layer = itemDropDataObj.postZ;

		with itemDrop {
			global.owner = id;
			global.makeLightOnCreate = true;
			lightRadius = instance_create_depth(x,y,1,obj_light_radius);
			lightRadius.x = x;
			lightRadius.y = y;
		}

	}*/
	
	// set all npc data 
	for (var i = 0; i < ds_list_size(npcData); i++) {
		var npcdata = ds_list_find_value(npcData,i);
		var npc = npcdata.npc;
		var currentC = ds_map_find_first(npcdata.conversations);
		for (var i = 0; i < ds_map_size(npcdata.conversations); i++) {
			
			// find conversation object in npc obj by name
			var cObj = noone;
			with obj_conversation_parent {
				if owner = npc && name == currentC {
					cObj = id;
				}
			}
			cObj.isFinished = ds_map_find_value(npcdata.conversations,currentC);
			
			currentC = ds_map_find_next(npcdata.conversations,currentC);
		}
	}
	
} else {
	// make itemDrops (persistent) not appear on screen at all 
	for (var i = 0; i < ds_list_size(itemDropsData); i++) {
		var itemDropDataObj = ds_list_find_value(itemDropsData,i);
		var itemDrop = findPersistentRoomElement(obj_item_drop,itemDropDataObj.postX,itemDropDataObj.postY);
		
		if itemDrop {
			itemDrop.x = -1000;
			itemDrop.y = -1000;
		} else {
			ds_list_delete(itemDropsData,i);
		}
	}
}