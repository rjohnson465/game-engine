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
	x = chosenPoint.x; y = chosenPoint.y;
}

// make sure some path to player exists -- otherwise, teleport again
if !mp_grid_path(personalGrid, gridPath, x, y, global.player.x, global.player.y, true) {
	alarm[4] = 1;
}

ds_list_destroy(allPoints); allPoints = -1; // mem leak