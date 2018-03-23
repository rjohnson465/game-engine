// on room start, create an instance of obj_room_data if there is not one fot this room yet
var roomDataObj = noone;
with obj_room_data {
	if roomIndex == room {
		roomDataObj = id;
	}
}

if roomDataObj == noone {
	instance_create_depth(x,y,1,obj_room_data);
}

// re-renter room with previously active enemies?
if type == CombatantTypes.Enemy {
	enemyData = findPersistentRoomElementData(obj_enemy_data,id);
	
	// remove your corpse if you've been respawned
	if enemyData.hp > 0 {
		var idd = id;
		with obj_enemy_dead {
			if owner == idd {
				instance_destroy(id,false);
			}
		}
	}
}

