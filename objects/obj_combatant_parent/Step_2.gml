if layer == global.player.layer && fallFrame >= fallTotalFrames {
	with obj_attack {
		var cpexists = script_execute(scr_collision_point,id,other.id)
		if place_meeting_layer(x,y,other.id) || cpexists || (isRanged && distance_to_object(other.id) < 5) {
			with other {
				var wallsBetween = scr_collision_line_list_layer(x, y, other.x, other.y, obj_wall_parent, true, true);
				var doorsBetween = scr_collision_line_list_layer(x, y, other.x, other.y, obj_door, true, true);
				var wallsBetweenAreSolid = false;
				
				if ds_exists(wallsBetween, ds_type_list) {
					for (var i = 0; i < ds_list_size(wallsBetween); i++) {
						var w = ds_list_find_value(wallsBetween, i);
						if w.stopsAttacks {
							wallsBetweenAreSolid = true;
						}
					}
				}
				
				// disallow attacking through doors and walls
				if (wallsBetween == noone || !wallsBetweenAreSolid) && doorsBetween == noone {
					calculateDamage();
				}
				if ds_exists(wallsBetween, ds_type_list) {
					ds_list_destroy(wallsBetween); wallsBetween = -1;
				}
				if ds_exists(doorsBetween, ds_type_list) {
					ds_list_destroy(doorsBetween); doorsBetween = -1;
				}
			}
		}
	}
}
previousFacingDirection = facingDirection;

if part_type_exists(sprintParticle) && isSprinting && hp >= 1 {
	part_type_direction(sprintParticle,movingDirection-45,movingDirection+45,0,0);
	part_type_orientation(sprintParticle,facingDirection, facingDirection,0,0,0);
	part_system_depth(sprintParticleSystem,depth+1);
	part_emitter_region(sprintParticleSystem, sprintParticleEmitter, x-1, x+1, y-1, y+1,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(sprintParticleSystem,sprintParticleEmitter,sprintParticle,-1);
}

// snow tunnel particles
if type == CombatantTypes.Player && room == rm_winter && path_index >= 0 && global.isTrading  {
	var icePart = ds_map_find_value(global.weaponParticlesMap, ICE);
	part_emitter_region(sprintParticleSystem, sprintParticleEmitter, x-1, x+1, y-1, y+1,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(sprintParticleSystem,sprintParticleEmitter,icePart,12);
}

var pDepth = global.player.depth;

if	type != CombatantTypes.Player && attackData != noone && attackData.prepPart1 != noone 
	&& part_type_exists(attackData.prepPart1) && ds_map_size(preparingLimbs) != 0 && depth >= pDepth {
	
	// make sure we should start prep particles 
	if (attackData.prepPartStartFrame != noone) {
		var ck = ds_map_find_first(prepFrames);
		var frame = ds_map_find_value(prepFrames, ck);
		if frame < attackData.prepPartStartFrame {
			exit;
		}
	}
	
	
	var parttype = attackData.prepPart1;
	
	if attackData.prepPart1BelowOwner {
		part_system_depth(appSystem, layer_get_depth(layer)+1);
	} else {
		part_system_depth(appSystem, layer_get_depth(layer) - 1);
	}
	
	var bbl = bbox_left; var bbr = bbox_right;
	var bbt = bbox_top; var bbb = bbox_bottom;
	
	// TODO maybe define a more specific burst region
	if (attackData.prepPartBoundingBox != noone) {
		
		// offsets
		var offsets = attackData.prepPartBoundingBox;
		var xo1 = offsets[0]; var yo1 = offsets[1];
		var xo2 = offsets[2]; var yo2 = offsets[3];
		/*var ofd = facingDirection;
		
		
		var radians = (pi/180) * ofd;
		var cx = x; var cy = y;
		var cs = cos(radians);
		var sn = sin(radians);

		
		var sx1 = x + xo1; var sy1 = y + yo1;
		var nx1 = (cs * (sx1 - cx)) + (sn * (sy1 - cy)) + cx;
		var ny1 = (cs * (sy1 - cy)) - (sn * (sx1 - cx)) + cy;
		
		var sx2 = x + xo2; var sy2 = y + yo2;
		var nx2 = (cs * (sx2 - cx)) + (sn * (sy2 - cy)) + cx;
		var ny2 = (cs * (sy2 - cy)) - (sn * (sx2 - cx)) + cy;*/
		var newTopLeft = rotateAndTranslatePoint(x, y, xo1, yo1, facingDirection);
		var newBottomRight = rotateAndTranslatePoint(x, y, xo2, yo2, facingDirection);
	
		bbl = newTopLeft[0]; var bbt = newTopLeft[1];
		bbr = newBottomRight[0]; var bbb = newBottomRight[1]; 
		
	}
	
	part_emitter_region(appSystem,appEmitter,bbl, bbr, bbt, bbb, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(appSystem,appEmitter,parttype, attackData.prepPart1Num);
}