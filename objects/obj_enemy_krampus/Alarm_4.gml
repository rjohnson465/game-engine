/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if state == CombatantStates.Attacking {
	alarm[4] = 1;
	exit;
}

audio_play_sound_at(snd_death_fade, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);

// teleport
damageTaken = 0;

var numPoints = instance_number(obj_teleport_point);
var allPoints = ds_list_create();

with obj_teleport_point {
	ds_list_add(allPoints, id);
}

randomize();
var pointIndex = round(random_range(0, numPoints - 1));

var chosenPoint = noone;
for (var i = 0; i < ds_list_size(allPoints); i++) {
	var pt = ds_list_find_value(allPoints, i);
	if i == pointIndex {
		chosenPoint = pt;
	}
}

if chosenPoint != noone {
	
	// do not allow teleport to the last teleport point you were at
	if TELEPORT_LAST_OBJ == chosenPoint {
		var firstPtIndex = pointIndex == 0 ? 1 : 0;
		chosenPoint = ds_list_find_value(allPoints, firstPtIndex);
	}
	
	TELEPORT_LAST_OBJ = chosenPoint;
	
	// burst some particles
	var iceSpell = instance_nearest(x, y, obj_attack_krampus_staff_3_1);
	var p = iceSpell.part1;
	part_emitter_region(appSystem, appEmitter, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(appSystem, appEmitter, p, 25);
	
	x = chosenPoint.x; y = chosenPoint.y;
	
	with obj_player {
		lockOnTarget = noone;
	}
}

ds_list_destroy(allPoints); allPoints = -1; // mem leak