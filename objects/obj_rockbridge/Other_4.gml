event_inherited();


isActive = ds_map_find_value(properties, "IsActive");

// if active, immediately move to goal x / y, then turn to bridge instance TODO

if isActive {
	x = goalX; y = goalY;
	
	global.bridgeSpriteIndex = sprite_index;
	global.bridgeAngle = image_angle;
			
	global.damageType = "Ground";
			
	global.x1 = x;
	global.y1 = y;
	global.particleDirection = 0;
	global.hitParticlesLayer = origLayer;
	global.victim = noone;
	instance_create_depth(x,y,1,obj_hit_particles);
	instance_change(obj_bridge_parent, 1);
}