/// fall()

jumpFrame = jumpTotalFrames; // cannot jump while falling
fallFrame++;
if fallFrame == .5*fallTotalFrames {
	var layerName = layer_get_name(layer);
	var layerNum = real(string_char_at(layerName,string_length(layerName)));
	var lowerLayerNum = layerNum-1;
	var lowerLayer = layer_get_id("instances_floor_"+string(lowerLayerNum));
	show_debug_message("lower layer: " + string(lowerLayerNum));
	layer = lowerLayer;
	updateRoomLayers();
	// if we've hit ground...
	var layerName = layer_get_name(layer);
	var layerNum = real(string_char_at(layerName,string_length(layerName)));
	var tilemap = layer_tilemap_get_id(layer_get_id("tiles_floor_"+string(layerNum)));
	var w = bbox_right-bbox_left;
	var h = bbox_bottom-bbox_top;
	var t1 = tilemap_get_at_pixel(tilemap,x-(.25*w),y-(.25*h));
	var t2 = tilemap_get_at_pixel(tilemap,x+(.25*w),y-(.25*h));
	var t3 = tilemap_get_at_pixel(tilemap,x-(.25*w),y+(.25*h));
	var t4 = tilemap_get_at_pixel(tilemap,x+(.25*w),y+(.25*h));
	if t1 == 0 && t2 == 0 && t3 == 0 && t4 == 0 {
		fallFrame = 0;
		floorsFallen++;
	} else {
		fallOnNearestFreePoint();
		global.damageType = PHYSICAL;
		global.x1 = x;
		global.y1 = y;
		global.particleDirection = direction;
		instance_create_depth(0,0,1,obj_hit_particles);
		global.damageAmount = 10*floorsFallen;
		global.victim = id;
		global.healingSustained = 0;
		instance_create_depth(x,y,1,obj_damage);
		hp -= 10*floorsFallen;
		floorsFallen = 0;
	}
}
// TODO handle collisions with solid objects on this floor
if fallFrame == fallTotalFrames {
	
}
state = CombatantStates.Idle;
path_end();
speed = 0;