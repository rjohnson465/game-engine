// maybe make particles at beam hit site
if !hasSetAlarm && beamHitLight != noone && instance_exists(beamHitLight) &&
	is_array(beamHitParticlesArr) && array_length_1d(beamHitParticlesArr) > 0 {
	if layer >= global.player.layer {
		
		part_emitter_region(system,emitter,beamHitLight.x,beamHitLight.x,beamHitLight.y,beamHitLight.y,ps_shape_ellipse,ps_distr_gaussian);
		
		for (var i = 0; i < array_length_1d(beamHitParticlesArr); i++) {
			var partArr = beamHitParticlesArr[i];
			var pt = partArr[0];
			var pn = partArr[1];
			
			// make beam hit particles go in opposite direction of beam
			var revAngle = (image_angle + 180) % 360;
			part_type_direction(pt, revAngle - 45, revAngle + 45, 0, 0);
			
			// emit beam hit particles
			part_emitter_burst(system,emitter,pt, pn);
		}
		
	}
}

// attacker turns to face beam at target
with owner {
	if lockOnTarget >= 0 {
		var ts = other.attackData.turnSpeedAttack == noone ? .25*turnSpeed : other.attackData.turnSpeedAttack
		turnToFacePoint(ts, lockOnTarget.x, lockOnTarget.y);
	}
}
// set beam angle to match attacker's angle
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

// find s, the closest solid object the beam is hitting (if it exists)
var possibleSolids = scr_collision_line_list_layer(owner.x,owner.y,xx,yy,obj_solid_parent,true,true, true);
var closestDist = 10000; var s = noone;
if possibleSolids != noone {
	for (var i = 0; i < ds_list_size(possibleSolids); i++) {
		var el = ds_list_find_value(possibleSolids,i);
		// beams may not friendly-fire
		if object_is_ancestor(el.object_index, obj_combatant_parent) && el.type == owner.type continue;
		// beams may not hit dodging combatants or dead ones
		if object_is_ancestor(el.object_index, obj_combatant_parent) && (el.state == CombatantStates.Dodging || el.hp <= 0) continue;
		if !object_is_ancestor(el.object_index, obj_combatant_parent) && !el.stopsAttacks continue;
		with owner {
			
			// List of all collision points for this obj, el, the line from owner x/y to beam's end makes
			var possibleCollisionPts = noone;
			if object_is_ancestor(el.object_index, obj_combatant_parent) {
				// if we're checking collision with a combatant, only use the combatant's x/y as
				// possible collision point (this way the combatant may take damage)
				possibleCollisionPts = ds_list_create();
				ds_list_add(possibleCollisionPts, [el.x, el.y]);
			} else {
				possibleCollisionPts = calcLineRectIntersection(el.bbox_left, el.bbox_top, el.bbox_right, el.bbox_bottom, x, y, xx, yy);
			}
			
			for (var j = 0; j < ds_list_size(possibleCollisionPts); j++) {
				var ptArr = ds_list_find_value(possibleCollisionPts, j);
				var ptX = ptArr[0];
				var ptY = ptArr[1];
				
				var dist = point_distance(x, y, ptX, ptY); 
				// if distance between owner and this beam collision point is closer than all other found so far
				// set "s", the first solid object the beam hits, to this el
				if dist < closestDist {
					closestDist = dist;
					s = el;
				}
			}
			
			ds_list_destroy(possibleCollisionPts); possibleCollisionPts = -1;
		}
	}
}

if ds_exists(possibleSolids, ds_type_list) {
	ds_list_destroy(possibleSolids); possibleSolids = -1;
}

// beam ends at s, the first solid it hits
if s >= 0 {
	
	var distToFirstSolid = 1000;
	with owner {
		distToFirstSolid = distance_to_object(s);
	}
	var xx = x + lengthdir_x(distToFirstSolid, owner.facingDirection);
	var yy = y + lengthdir_y(distToFirstSolid, owner.facingDirection);
	
	var intersectPts = noone;
	if !object_is_ancestor(s.object_index, obj_combatant_parent) {
		intersectPts = calcLineRectIntersection(s.bbox_left, s.bbox_top, s.bbox_right, s.bbox_bottom, owner.x, owner.y, xx, yy);
	} else {
		intersectPts = ds_list_create();
		ds_list_add(intersectPts, [s.x, s.y]);
	}
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
		
		// if beam makes a light on hit and it has not yet made that light, do that now
		if attackData.beamHitMakesLight && beamHitLight == noone {
			global.makeLightOnCreate = true;
			global.owner = id;
			lightRadiusAlpha = attackData.beamHitLightAlpha;
			lightRadiusColor = attackData.beamHitLightColor;
			lightRadiusScale = attackData.beamHitLightScale;
			lightRadiusSprite = spr_light_point;
			beamHitLight = instance_create_depth(cx, cy, depth, obj_light_radius);
		} else if beamHitLight != noone && instance_exists(beamHitLight) {
			beamHitLight.x = cx; beamHitLight.y = cy;
		}
		
	}
}
// otherwise, don't show the beam hit light (if applicable)
else if beamHitLight != noone && instance_exists(beamHitLight) {
	beamHitLight.x = -1000; beamHitLight.y = -1000;
}

// position the beamHit sound emitter at the beam hit light object
with beamHitLight {
	audio_emitter_position(other.beamHitSoundEmitter, x, y, depth);
}

if beamReach <= 0 {
	beamReach = 1;
}
image_xscale = beamReach;

if attackData.beamHasLight {
	_light_angle = image_angle;
	_light_xscale = image_xscale / sprite_get_width(spr_light_square_midleft);
	// show_debug_message("image xscale " + string(image_xscale) + "; light_xscale " + string(_light_xscale));
	// randomly waver the beam's width
	randomize();
	var rand = random_range(attackData.beamWidthWaverArray[0], attackData.beamWidthWaverArray[1]);
	_light_yscale = rand;
	
	// maybe also randomly waver the beamHitLight, if it exists
	if beamHitLight != noone && instance_exists(beamHitLight) {
		with beamHitLight {
			randomize();
			var rand = random_range(other.attackData.beamHitLightScaleWaverArray[0], other.attackData.beamHitLightScaleWaverArray[1]);
			_light_scale = rand;
		}
	}
}

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
	alarm[0] = 15;
	hasSetAlarm = true;
	image_speed = 0;
}

if hasSetAlarm {
	var gain = alarm[0]/15;
	image_alpha = gain;
	_light_alpha = gain * attackData.beamLightAlpha;
	
	if beamHitLight != noone && instance_exists(beamHitLight) {
		with beamHitLight {
			_light_alpha = gain * other.attackData.beamHitLightAlpha;
		}
	}
}