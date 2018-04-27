if place_meeting(x,y,obj_player) {
	jumpToNearestFreePoint(1);
}

/*
// e-renter room with previously active enemies?
if type == CombatantTypes.Enemy && enemyData != noone {
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

