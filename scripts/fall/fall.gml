/// fall()

// stop any and all attacks

// stop preparing attacks
if ds_map_size(preparingLimbs) != 0 {
	var hand = ds_map_find_first(preparingLimbs);
	for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
		ds_map_replace(prepFrames,hand,-1);
		ds_map_replace(prepFrameTotals,hand,0);
		ds_map_delete(preparingLimbs,hand);
		hand = ds_map_find_next(preparingLimbs,hand);
	}
}
// stop attacking
if ds_map_size(attackingLimbs) != 0 {
	var hand = ds_map_find_first(attackingLimbs);
	for (var i = 0; i < ds_map_size(attackingLimbs); i++) {
		ds_map_delete(attackingLimbs,hand);
		hand = ds_map_find_next(attackingLimbs,hand);
	}
}
// stop recovering attacks
if ds_map_size(recoveringLimbs) != 0 {
	var hand = ds_map_find_first(recoveringLimbs);
	for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
		ds_map_replace(recoveringLimbs,hand,-1);
		ds_map_replace(recoveringLimbs,hand,0);
		ds_map_delete(recoveringLimbs,hand);
		hand = ds_map_find_next(recoveringLimbs,hand);
	}
}
isStrafing = false;
currentUsingSpell = noone;
attackNumberInChain = noone;
isShielding = false;
dodgeFrame = 0;

jumpFrame = jumpTotalFrames; // cannot jump while falling
fallFrame++;
if fallFrame == .5*fallTotalFrames {
	var layerName = layer_get_name(layer);
	var layerNum = real(string_char_at(layerName,string_length(layerName)));
	var lowerLayerNum = layerNum-1;
	var lowerLayer = layer_get_id("instances_floor_"+string(lowerLayerNum));

	layer = lowerLayer;
	updateRoomLayers();
	
	// check if we should keep falling
	var keepFalling = false;
	with obj_fallzone {
		var d = point_in_rectangle(other.bbox_left+10,other.bbox_top+10,bbox_left,bbox_top,bbox_right,bbox_bottom);
		var e = point_in_rectangle(other.bbox_right-10,other.bbox_bottom-10,bbox_left,bbox_top,bbox_right,bbox_bottom);
		if	d && e && layer == other.layer {
			keepFalling = true;
		}
	}
	if keepFalling {
		fallFrame = 0;
		floorsFallen++;
	}
	else {
		jumpToNearestFreePoint();
		global.damageType = PHYSICAL;
		global.x1 = x;
		global.y1 = y;
		global.particleDirection = direction;
		instance_create_depth(0,0,1,obj_hit_particles);
		var fallDamage = 10*floorsFallen;
		if fallDamage > hp {
			fallDamage = hp;
		}
		global.damageAmount = fallDamage;
		global.victim = id;
		global.healingSustained = 0;
		global.isCriticalHit = false;
		instance_create_depth(x,y,1,obj_damage);
		hp -= fallDamage;
		audio_play_sound(snd_crunchy_thud,1,0);
		floorsFallen = 0;
		tempPostX = x;
		tempPostY = y;
		if type == CombatantTypes.Enemy {
			enemyData.tempPostX = tempPostX;
			enemyData.tempPostY = tempPostY;
		}
	}
}
state = CombatantStates.Idle;
path_end();
speed = 0;