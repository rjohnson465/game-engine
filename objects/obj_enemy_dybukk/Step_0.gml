/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
if isAggroed {
	event_inherited();
} else {
	
	// behavior for Saving Hershel
	
	// chase down hersehl
	var hershel = instance_nearest(x, y, obj_hershel);
	if instance_exists(hershel) {
		turnToFacePoint(4, hershel.x, hershel.y);
		if distance_to_object(hershel) > 20 {
			mp_potential_step(hershel.x, hershel.y, functionalSpeed, false);
		}
		
		
		// burst particles over hershel
		var x1 = hershel.bbox_left; var x2 = hershel.bbox_right;
		var y1 = hershel.bbox_top; var y2 = hershel.bbox_bottom;
		part_emitter_region(sporeSystem,sporeEmitter,x1,x2,y1,y2,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(sporeSystem,sporeEmitter,possessParticle, 4);
		
		// also burst possess particles over yourself
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;
		part_emitter_region(sporeSystem,sporeEmitter,x1,x2,y1,y2,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(sporeSystem,sporeEmitter,possessParticle, 2);
	
	} 
	
	with obj_combatant_parent {
		if !canIntersectWithAllies && other.hp > 1 && layer == global.player.layer && distance_to_object(other) < 64 {
			if place_meeting_layer(x,y,other) {
				var dir;
				var move_dis = functionalSpeed;  // change this value to your liking

				// If the two instances are in the same location, choose a random direction
				if (x == other.x && y == other.y)
				    dir = random(360);

				// Otherwise, choose the direction opposite of the other instance
				else
				    dir = point_direction(other.x,other.y,x,y);

				// nudge instance to new location if possible

				var dx = lengthdir_x(move_dis,dir);
				var dy = lengthdir_y(move_dis,dir);

				if (!place_meeting(x+dx,y,obj_solid_environment)) {
					x += dx;
				}
				if (!place_meeting(x,y+dy,obj_solid_environment)) {
					y += dy;
				}
				maybeMarkGridCellTempFree(x, y);
				//jumpToNearestFreePoint(1,1,functionalSpeed);
			}
		}
	}
	
}

// always be bursting particles
if hp > 1 {
	if layer >= global.player.layer {
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;
		part_emitter_region(sporeSystem,sporeEmitter,x1,x2,y1,y2,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(sporeSystem,sporeEmitter,sporeParticle, 2);
	}
}