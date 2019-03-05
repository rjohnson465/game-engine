var isHittingSolid = false;
with obj_solid_environment {
	var _dist = distance_to_object(other);
	if _dist <= 1 && layer == other.layer {
		isHittingSolid = true;
		var a = 3;
	}
}


if place_meeting_layer(x,y,obj_solid_environment) || isHittingSolid {
	var x1 = x + lengthdir_x(100,facingDirection);
	var y1 = y + lengthdir_y(100,facingDirection);
	var firstObj = noone;
	var possibleSolids = scr_collision_line_list_layer(x,y,x1,y1,obj_solid_parent,true,true);
	if possibleSolids != noone {
		//var closestDist = 1000;
		for (var i = 0; i < ds_list_size(possibleSolids); i++) {
			var el = ds_list_find_value(possibleSolids,i);
			var _dist = distance_to_object(el);
			var _isTouching = place_meeting_layer(x,y,el);
			if !object_is_ancestor(el.object_index,obj_combatant_parent) && _isTouching {
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
	
	//var hitsWallFirst = object_is_ancestor(firstObj.object_index
	if isMelee {
		if owner.type == CombatantTypes.Player {
			if weapon.weaponType != UNARMED {
				damageItem(weapon,1/3);
			}
		}
		owner.staggerFrame = 0;
		owner.staggerDuration = 5;
		owner.staggerDirection = (owner.facingDirection+180)%360;
		path_end();
		// run to get __x and __y (collision point where attack meet this combatant)
		if script_execute(scr_collision_point,id,firstObj.id) {
		//script_execute(scr_collision_point,id,other.id)
			global.damageType = firstObj.material == METAL ? "Block" : "Dust";
			if owner.type == CombatantTypes.Player && weapon.weaponType == UNARMED {
				global.damageType = "Dust";
			}
			global.x1 = __x;
			global.y1 = __y;
			global.particleDirection = facingDirection;
			global.hitParticlesLayer = layer;
			global.victim = firstObj;
			instance_create_depth(0,0,1,obj_hit_particles);
			if !isSpell {
				// play wall hit sound, dependent on type of material wall is
				var snd = global.damageType == "Dust" ? snd_shield_hit_wood : snd_wallhit;
				audio_play_sound_at(snd,__x,__y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			}
		}
	
		if owner.hasHands {
			var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
			ds_map_delete(owner.attackingLimbs,limbKey);
		}
	
		instance_destroy(id,true);
		owner.state = CombatantStates.Staggering;
	}
	
	// make dust / spark particles, play sound, for range
	if isRanged && !hasSetAlarm {
		global.damageType = firstObj.material == METAL ? "Block" : "Dust";
		if isSpell {
			global.damageType = spellElement;
		}
		global.x1 = x + lengthdir_x(bbox_right-bbox_left,facingDirection);
		global.y1 = bbox_bottom;
		global.particleDirection = facingDirection;
		global.hitParticlesLayer = layer; 
		global.victim = firstObj;
		instance_create_depth(0,0,1,obj_hit_particles);
		alarm[0] = 25;
		visible = 0;
		speed = 0;
		hasSetAlarm = true;
		if !isSpell {
			var snd = firstObj.material == METAL ? snd_wallhit : snd_shield_hit_wood;
			audio_play_sound_at(snd,global.x1,global.y1,depth,20,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		} else {
			audio_stop_sound(sound);
			var snd = asset_get_index("snd_magic_"+owner.currentSpellAttunement+"_hit");
			audio_play_sound_at(snd,global.x1,global.y1,depth,20,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		}
	}

	if isSpell && !hasSetAlarm {
		var attunement = MAGIC;
		for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
			var el = global.ALL_ELEMENTS[i];
			var arr = ds_map_find_value(spell.damages,el);
			if arr[1] != 0 {
				attunement = global.ALL_ELEMENTS[i];
			}
		}
		global.damageType = attunement;
		global.x1 = x + lengthdir_x(bbox_right-bbox_left,facingDirection);
		global.y1 = bbox_bottom;
		global.particleDirection = facingDirection;
		global.hitParticlesLayer = layer;
		instance_create_depth(0,0,1,obj_hit_particles);
		//instance_destroy(id,true);
		alarm[0] = 15;
		visible = 0;
		speed = 0;
		x = global.x1;
		y = global.y1;
		hasSetAlarm = true;
	}

	if isRanged && !hasSetAlarm {
		var idd = id;
		with obj_light_radius {
			if owner == idd {
				instance_destroy(id);
			}
		}
	}
	
}
