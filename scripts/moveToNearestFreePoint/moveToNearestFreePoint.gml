/// moveToNearestFreePoint(direction,speed,*isEnemy,*includesFallzones, *angMult)
/// @param direction
/// @param speed
/// @param *isEnemy
/// @param *includesFallzones
/// @param *angMult angle multiple to check -- default is 5.625

/// returns true if the instance can move in that general direction

var d = argument[0];
var sp = argument[1];
var isEnemy = false;
if argument_count > 2 {
	isEnemy = argument[2];
}
var includesFallzones = false;
if argument_count > 3 {
	includesFallzones = argument[3];
}
var angMult = 11.25;
if argument_count > 4 {
	angMult = argument[4];
}

d = d mod 360;

var objectsToAvoid = obj_solid_parent;
//var additionalObjects = ds_list_create();
if isEnemy objectsToAvoid = obj_enemy_obstacle_parent;

// also look out for ridges that we aren't already touching whose fallDirectionMin / max are antithetical to the direction we want to go
var ridges = ds_list_create();
if object_is_ancestor(object_index, obj_combatant_parent) {
	with obj_ridge {
		if distance_to_object(other) < 15 {
			var isRidgeActiveForCombatant = ds_list_find_index(other.activeRidges, id) != -1;
			if !isRidgeActiveForCombatant && !angleBetween(fallDirectionMin, fallDirectionMax, d) {
				ds_list_add(ridges, id);
			}
		}
	}
}

var wouldHitRidge = false;
if ds_list_size(ridges) > 0 {
	for (var i = 0; i < ds_list_size(ridges); i++) {
		var r = ds_list_find_value(ridges, i);
		if place_meeting_layer(x + lengthdir_x(sp, d), y + lengthdir_y(sp, d), r) {
			wouldHitRidge = true;
		}
	}
}

var solidNpcs = ds_list_create();
if object_index == obj_player {
	with obj_npc_parent {
		if isSolid && distance_to_object(global.player) < 15 {
			ds_list_add(solidNpcs, id);
		}
	}
}
var wouldHitSolidNpc = false;
if id == global.player && ds_list_size(solidNpcs) > 0 {
	for (var i = 0; i < ds_list_size(solidNpcs); i++) {
		var n = ds_list_find_value(solidNpcs, i);
		if place_meeting_layer(x + lengthdir_x(sp, d), y + lengthdir_y(sp, d), n) {
			wouldHitSolidNpc = true;
		}
	}
}


var oldX = x;
var oldY = y;
var dir = d;

var wouldHitObjectToAvoid = place_meeting_layer(x+lengthdir_x(sp,dir),y+lengthdir_y(sp,dir),objectsToAvoid, solidNpcs);

var pred1 = includesFallzones ? 
			!wouldHitObjectToAvoid && !place_meeting_layer(x+lengthdir_x(sp,dir),y+lengthdir_y(sp,dir),obj_fallzone) && !wouldHitRidge && !wouldHitSolidNpc
			: !wouldHitObjectToAvoid && !wouldHitRidge && !wouldHitSolidNpc; 

// if !place_meeting_layer(x+lengthdir_x(sp,d),y+lengthdir_y(sp,d),objectsToAvoid) {
if pred1 {
	x = x+lengthdir_x(sp,d); 
	y = y+lengthdir_y(sp,d);
	direction = point_direction(oldX,oldY,x,y);
	return true;
}
else {
	
	var possibleAngles = ds_list_create();
	dir = (dir + angMult)%360; 
	while dir != d
	{
		if abs(angle_difference(d,dir) < 100) {
			// check again for ridge collisions
			var wouldHitRidge = false;
			if ds_list_size(ridges) > 0 {
				for (var i = 0; i < ds_list_size(ridges); i++) {
					var r = ds_list_find_value(ridges, i);
					if place_meeting_layer(x + lengthdir_x(sp, dir), y + lengthdir_y(sp, dir), r) {
						wouldHitRidge = true;
					}
				}
			}
			var wouldHitSolidNpc = false;
			if id == global.player && ds_list_size(solidNpcs) > 0 {
				for (var i = 0; i < ds_list_size(solidNpcs); i++) {
					var n = ds_list_find_value(solidNpcs, i);
					if place_meeting_layer(x + lengthdir_x(sp, dir), y + lengthdir_y(sp, dir), n) {
						wouldHitSolidNpc = true;
					}
				}
			}
		
			var wouldHitObjectToAvoid = place_meeting_layer(x+lengthdir_x(sp,dir),y+lengthdir_y(sp,dir),objectsToAvoid, solidNpcs);
			var wouldHitFallzone = place_meeting_layer(x+lengthdir_x(sp,dir),y+lengthdir_y(sp,dir),obj_fallzone);
		
			var pred =	includesFallzones ? 
						!wouldHitObjectToAvoid && !wouldHitFallzone && !wouldHitRidge && !wouldHitSolidNpc
						: !wouldHitObjectToAvoid && !wouldHitRidge && !wouldHitSolidNpc;
		
			//if !place_meeting_layer(x+lengthdir_x(sp,dir),y+lengthdir_y(sp,dir),objectsToAvoid) {
			if pred {	
			
				x = x+lengthdir_x(sp,dir); 
				y = y+lengthdir_y(sp,dir); 
			
				/*
				// check again for ridge collisions
				var wouldHitRidge = false;
				if ds_list_size(ridges) > 0 {
					for (var i = 0; i < ds_list_size(ridges); i++) {
						var r = ds_list_find_value(ridges, i);
						if place_meeting_layer(x, y, r) {
							wouldHitRidge = true;
						}
					}
				}
				var wouldHitSolidNpc = false;
				if id == global.player && ds_list_size(solidNpcs) > 0 {
					for (var i = 0; i < ds_list_size(solidNpcs); i++) {
						var n = ds_list_find_value(solidNpcs, i);
						if place_meeting_layer(x, y, n) {
							wouldHitSolidNpc = true;
						}
					}
				} */
			
				if place_meeting_layer(x,y,objectsToAvoid, solidNpcs) || wouldHitRidge {
					x = oldX;
					y = oldY;
				} else {
					ds_list_add(possibleAngles,dir);
					x = oldX;
					y = oldY;
				}
			
				/*
				var wouldHitObjectToAvoid = place_meeting_layer(x+lengthdir_x(sp,dir),y+lengthdir_y(sp,dir),objectsToAvoid, solidNpcs);
			
				pred =	includesFallzones ? 
						!wouldHitObjectToAvoid && !place_meeting_layer(x+lengthdir_x(sp,dir),y+lengthdir_y(sp,dir),obj_fallzone) && !wouldHitRidge && !wouldHitSolidNpc
						: !wouldHitObjectToAvoid && !wouldHitRidge && !wouldHitSolidNpc;
			    */
			}
		}
		dir = (dir + angMult)%360;
	}
	// find closest possible angle
	var closestAngleDiff = 360;
	for (var i = 0; i < ds_list_size(possibleAngles); i++) {
		var ang = ds_list_find_value(possibleAngles,i);
		var diff = abs(angle_difference(d,ang));
		if diff < closestAngleDiff {
			closestAngleDiff = diff;
			dir = ang;
		}				
	}
	// only move if some angle was ok
	// if dir == d exit;
	if dir != d && abs(angle_difference(d,dir)) < 90 {
		// bigger angle diff = slower speed
		var diff = abs(angle_difference(d,dir));
		// linear
		//sp = (-(diff/90)+1)*sp;
		// quadratic
		sp = (1-((diff*diff)/8100))*sp;
		// logarithmic
		//sp = (1/(log10(90))*log10(-(diff-90)))*sp;
		x = x+lengthdir_x(sp,dir); 
		y = y+lengthdir_y(sp,dir);
		direction = point_direction(oldX,oldY,x,y);

		ds_list_destroy(possibleAngles); possibleAngles = -1;
		ds_list_destroy(ridges); ridges = -1;
		return true;
	}
	ds_list_destroy(possibleAngles); possibleAngles = -1;
	ds_list_destroy(ridges); ridges = -1;
	ds_list_destroy(solidNpcs); solidNpcs = -1;
}
//ds_list_destroy(additionalObjects); additionalObjects = -1;
