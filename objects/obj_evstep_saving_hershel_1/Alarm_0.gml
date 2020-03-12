if status != EventStepStatus.InProgress exit;

if ds_list_size(ghostsSpawnedList) >= GHOSTS_TO_SPAWN_COUNT exit;
// if there are 3 dybukks spawned already, do not spawn another yet
var numGhostsAlive = 0;
for (var i = 0; i < ds_list_size(ghostsSpawnedList); i++) {
	var g = ds_list_find_value(ghostsSpawnedList, i);
	if g.hp > 0 {
		numGhostsAlive++;
	}
}

if numGhostsAlive > 2 {
	alarm[0] = random_range(GHOST_SPAWN_STAGGER_RANGE[0], GHOST_SPAWN_STAGGER_RANGE[1]);
	exit;
}

randomize();
var ptToSpawnAtIndex = round(random_range(0, array_length_1d(ghostSpawnPoints) - 1));
var ptToSpawnAt = ghostSpawnPoints[ptToSpawnAtIndex];

var xx = ptToSpawnAt[0]; var yy = ptToSpawnAt[1];
var hershel = instance_nearest(x, y, obj_hershel);
var dybukk = instance_create_layer(xx,yy,global.player.layer,obj_enemy_dybukk);
audio_play_sound_at(snd_magic_magic_shoot, xx, yy, global.player.depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
with dybukk {
	doesEnemyRespawn = false;
	populatePersonalGrid();
	facingDirection = point_direction(x, y, hershel.x, hershel.y);
	attackFrequencyTotalFramesMeleeDefault = attackFrequencyTotalFramesMelee;
	attackFrequencyTotalFramesRangedDefault = attackFrequencyTotalFramesRanged;
	
	// dybbuk wont care about player until struck
	isAggroed = false;
	hasSetUnaggroAlarm = false;
	beamSoundShootIndex = noone;
	beamSoundLoopIndex = noone;
	eventListeners = ds_map_create();
	ds_map_replace(eventListeners, EV_DAMAGE_TAKEN, scr_evl_helpinghershel_dybbuk_aggro);
		
	var lr = noone;
	with obj_light_radius {
		if owner == other.id {
			lr = id;
		}
	}
	if lr != noone {
		with lr {
			event_perform(ev_other, ev_room_start);
		}
	}
	jumpToNearestFreePoint(true, true);
	
	xpReward = 0;
}

ds_list_add(ghostsSpawnedList, dybukk);

alarm[0] = random_range(GHOST_SPAWN_STAGGER_RANGE[0], GHOST_SPAWN_STAGGER_RANGE[1]);