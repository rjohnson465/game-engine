if place_meeting_layer(x,y,obj_solid_environment) {
	var x1 = x + lengthdir_x(100,facingDirection);
	var y1 = y + lengthdir_y(100,facingDirection);
	var firstObj = noone;
	var possibleSolids = scr_collision_line_list_layer(x,y,x1,y1,obj_solid_parent,true,true);
	if possibleSolids != noone {
		var closestDist = 1000;
		for (var i = 0; i < ds_list_size(possibleSolids); i++) {
			var el = ds_list_find_value(possibleSolids,i);
			if !object_is_ancestor(el.object_index,obj_combatant_parent) && distance_to_object(el) < closestDist {
				firstObj = el;
			}
		}
	}
	
	if possibleSolids != noone && ds_exists(possibleSolids, ds_type_list) {
		ds_list_destroy(possibleSolids); possibleSolids = -1;
	}
	
	if firstObj == noone || !firstObj.stopsAttacks exit;
	
	if firstObj.object_index == obj_sconce && isRanged exit; // sconces are a special case

	with obj_enemy_parent {
		if layer == global.player.layer && fallFrame >= fallTotalFrames {
			if place_meeting_layer(x,y,firstObj.id) && state != CombatantStates.Dodging {
				exit;
			}
		}
	}

	if object_is_ancestor(firstObj.object_index,obj_combatant_parent) {
		exit;
	}

	if object_is_ancestor(firstObj.object_index, obj_npc_parent) && isRanged {
		instance_destroy(id); exit;
	}

	if global.player.layer == layer && (firstObj.layer != layer && abs(abs(firstObj.depth)-abs(depth)) > 5) {
		exit;
	}

	// make dust / spark particles, play sound, for range
	if !hasSetAlarm {
		global.damageType = attackData.damageType;
		global.x1 = x + lengthdir_x(bbox_right-bbox_left,facingDirection);
		global.y1 = bbox_bottom;
		global.particleDirection = facingDirection;
		global.hitParticlesLayer = origLayer; 
		global.victim = firstObj;
		instance_create_depth(0,0,1,obj_hit_particles); // dust particles
		// aoe particles
		global.damageType = attackData;
		instance_create_depth(0,0,1,obj_hit_particles);
		
		alarm[0] = 15;
		visible = 0;
		speed = 0;
		hasSetAlarm = true;
		//var snd = firstObj.material == METAL ? snd_wallhit : snd_shield_hit_wood;
		var snd = attackData.damageType == "Dust" ? snd_shield_hit_wood : snd_wallhit;
		audio_play_sound_at(snd,global.x1,global.y1,depth,20,AUDIO_MAX_FALLOFF_DIST,1,0,1);

	}

	if !hasSetAlarm {
		var idd = id;
		with obj_light_radius {
			if owner == idd {
				instance_destroy(id);
			}
		}
	}
	
}
