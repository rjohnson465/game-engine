if status != EventStepStatus.InProgress exit;

if ds_list_size(ghostsSpawnedList) >= GHOSTS_TO_SPAWN_COUNT exit;

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
}

ds_list_add(ghostsSpawnedList, dybukk);

alarm[0] = random_range(GHOST_SPAWN_STAGGER_RANGE[0], GHOST_SPAWN_STAGGER_RANGE[1]);