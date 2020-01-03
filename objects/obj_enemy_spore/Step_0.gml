
if !sporeIsInactive {
	event_inherited();
}
// if spore is "inactive", just move in sporeDirection as best as you can
else {
	
	if (global.player.lockOnTarget == id) {
		global.player.lockOnTarget = noone;
	}
	
	moveToNearestFreePoint(sporeDirection,functionalSpeed,1,0);
	sporeTimer--;
	if sporeTimer <= 0 {
		sporeIsInactive = false;
		isInvulnerable = false;
		state = CombatantStates.Idle;
		substate = CombatantMoveSubstates.Chasing;
		
		// since this is a dynamically added enemy, we must manually add it to the room data
		with obj_room_data {
			// regenerate key so it is unique from the other spores in its pod
			
			ds_map_add_map(enemiesData, other.key, ds_map_deep_clone(other.persistentProperties));
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
	
	// maybe damage player / good guy
	with obj_goodguy_parent {
		if place_meeting_layer(x,y,other) {
			if !moveToNearestFreePoint(other.sporeDirection,other.functionalSpeed,0,0) {
				jumpToNearestFreePoint(type==CombatantTypes.Enemy,0);
			}
			if other.alarm[4] == 1 {
				var damagesMap = ds_map_create();
				ds_map_replace(damagesMap,POISON,[1,4]);
				ds_map_replace(damagesMap,CRUSH,[1,1]);
				damageCombatant(damagesMap,2,other.sporeDirection,snd_hit1,other);
				ds_map_destroy(damagesMap); damagesMap = -1;
			}
		}
	}
}

// always be bursting particles
if hp > 1 {
	if layer >= global.player.layer {
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;
		part_emitter_region(sporeSystem,sporeEmitter,x1,x2,y1,y2,ps_shape_ellipse,0);
		part_emitter_burst(sporeSystem,sporeEmitter,sporeParticle, 2);
	}
}