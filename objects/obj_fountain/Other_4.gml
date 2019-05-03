event_inherited();

isDoneFilling = ds_map_find_value(properties, "isDoneFilling");
if isDoneFilling == undefined {
	isDoneFilling = false;
}
if isDoneFilling {
	isRunning = true;
}

if isRunning || (global.player.justRevivedAtFountain && distance_to_object(obj_player) < 100) {
	sprite_index = asset_get_index("spr_fountain_full");
	isDoneFilling = true;
	audio_emitter_gain(fountainRunningSoundEmitter,1);
	fountainRunningSoundIndex = audio_play_sound_on(fountainRunningSoundEmitter, fountainRunningSound, 1, 1);
	var lr = noone;
	with obj_light_radius {
		if owner == other.id {
			lr = id;
		}
	}
	if lr == noone {
		global.owner = id;
		global.makeLightOnCreate = true;
		instance_create_depth(x,y,1,obj_light_radius);
	}
}

/*
if isRunning {
	audio_emitter_gain(fountainRunningSoundEmitter,1);
}


