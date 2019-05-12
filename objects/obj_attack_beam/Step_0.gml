image_angle = facingDirection;
if !hasSetAlarm && part_type_exists(particle) {
	if layer >= global.player.layer {
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;

		// randomly spawn 4(??) particles somewhere in the collision mask of sprite_index
		for (var i = 0; i < 4; i++) {
			var xx = -50; var yy = -50;
			var pm = false;
			do {
				randomize();
				xx = random_range(x1,x2); yy = random_range(y1,y2);
				var parti = instance_create_depth(xx,yy,1,obj_attack_zone_part);
				var pm = place_meeting(x,y,parti);
				instance_destroy(parti,1);
			} until (pm)
			//part_particles_create(system,xx,yy,particle,1);
			part_emitter_region(system,emitter,xx,xx,yy,yy,ps_shape_ellipse,ps_distr_gaussian);
			part_emitter_burst(system,emitter,particle, 1);
		}
		
	}
}

// attacker turns to face beam at target
with owner {
	if lockOnTarget >= 0 {
		turnToFacePoint(.25*turnSpeed, lockOnTarget.x, lockOnTarget.y);
	}
}
image_angle = owner.facingDirection;


// reset xscale based on how long until a solid object is hit
var beamReach = beamMaxReach;
var beamFramePercent = beamFrame / beamFrameTotal; 
// if in first 25% of beam's life, beam will not be at 100% length 
if beamFramePercent <= .25 {
	beamReach = (4*beamFramePercent) * beamMaxReach;
}
beamFrame++;

var xx = x + lengthdir_x(beamReach, owner.facingDirection);
var yy = y + lengthdir_y(beamReach, owner.facingDirection);

var s = scr_collision_line_first(owner.x, owner.y, xx, yy, obj_wall_parent, true, true, owner.layer); //ds_list_find_value(solids, 0);
if s >= 0 {
	var distToFirstSolid = 1000;
	with owner {
		distToFirstSolid = distance_to_object(s);
	}
	var xx = x + lengthdir_x(distToFirstSolid, owner.facingDirection);
	var yy = y + lengthdir_y(distToFirstSolid, owner.facingDirection);
	
	var intersectPts = calcLineRectIntersection(s.bbox_left, s.bbox_top, s.bbox_right, s.bbox_bottom, owner.x, owner.y, xx, yy);
	if ds_list_size(intersectPts) > 0 {
		// find the closest intersect point to owner and use that one
		var closestDist = 10000; var cx = noone; var cy = noone;
		for (var i = 0; i < ds_list_size(intersectPts); i++) {
			var pt = ds_list_find_value(intersectPts, i);
			var dist = point_distance(owner.x, owner.y, pt[0], pt[1]);
			if dist < closestDist {
				closestDist = dist;
				cx = pt[0]; cy = pt[1];
			}
		}
		beamReach = point_distance(owner.x, owner.y, cx, cy);
	}
}
	

if beamReach <= 0 beamReach = 1;
image_xscale = beamReach;


if owner.state == CombatantStates.Staggering && !hasSetAlarm {
	// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
	if ds_exists(combatantsHit, ds_type_list) {
		for (var i = 0; i < ds_list_size(combatantsHit); i++) {
			var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
			if instance_exists(combatantHitWithThisAttack) && object_is_ancestor(combatantHitWithThisAttack.object_index, obj_combatant_parent) {
				ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
			}
		}
	}


	// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
	var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
	ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
	// set recoverFrames to -1
	ds_map_replace(owner.recoverFrames,limbKey,-1);
		
	// remove limbKey from attackingLimbs map
	ds_map_delete(owner.attackingLimbs,limbKey);
		
	owner.prevAttackHand = limbKey;
	//instance_destroy(id, true);
	alarm[0] = 30;
	hasSetAlarm = true;
	image_speed = 0;
}

if hasSetAlarm {
	var gain = alarm[0]/30;
	image_alpha = gain;
}