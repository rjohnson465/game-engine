
if !sporeIsInactive {
	event_inherited();
}
// if spore is "inactive", just move in sporeDirection as best as you can
else {
	moveToNearestFreePoint(sporeDirection,functionalSpeed,1,0);
	sporeTimer--;
	if sporeTimer <= 0 {
		sporeIsInactive = false;
		isInvulnerable = false;
		state = CombatantStates.Idle;
		substate = CombatantMoveSubstates.Chasing;
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
		/*if particle2 {
			part_emitter_burst(system,emitter,particle2, 2);
		}*/
	}
}


//show_debug_message(sprite_get_name(sprite_index));