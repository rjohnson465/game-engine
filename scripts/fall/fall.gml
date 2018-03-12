/// fall()

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
		instance_create_depth(x,y,1,obj_damage);
		hp -= fallDamage;
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