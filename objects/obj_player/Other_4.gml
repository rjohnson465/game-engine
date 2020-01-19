global.isReadingTutorial = false;
if global.playerDoNothing exit;
if room == game_menu exit;

ds_list_clear(interactableObjects); currentInteractableObject = noone;

updateEquipLoadSpeedModifier();

if variable_global_exists("newGameStarted") && global.newGameStarted {
	// hard code first fountain
	var nearestFountain = instance_nearest(x,y,obj_fountain);
	lastFountain = nearestFountain;
	lastFountainX = lastFountain.spawnX;
	lastFountainY = lastFountain.spawnY;
	lastFountainZ = lastFountain.layerName;
	lastFountainRoom = room;
	
	global.newGameStarted = false;
} else if lastFountainRoom == noone {
	lastFountainRoom = lastFountain.nativeRoom;
	lastFountainX = lastFountain.spawnX;
	lastFountainY = lastFountain.spawnY;
	lastFountainZ = lastFountain.layerName;
}

event_inherited();

// get player light radius, if it for some reason has become invalid
if !instance_exists(playerLightRadius) {
	with obj_light_radius {
		if owner == other {
			other.playerLightRadius = id;
		}
	}
}

isShowingLightRadius = true;
if layerToMoveTo != noone {
	layer = layer_get_id(layerToMoveTo);
	updateLightLayer(playerLightRadius,noone,layer);
}


// handles layer shading
global.isUpdatingRoomLayers = true;


audio_emitter_free(walkingInWaterEmitter); walkingInWaterEmitter = -1;
walkingInWaterEmitter = audio_emitter_create();
audio_emitter_gain(walkingInWaterEmitter,0);
//audio_play_sound_on(walkingInWaterEmitter,snd_water_floating_loop,1,0);






/// test shit
var m1 = ds_map_create();
var m2 = ds_map_create();

ds_map_add_map(m1, "map2", m2);

ds_map_destroy(m1); m1 = -1; // what does m2 evalute to now?

var m3 = ds_map_create();
var m3 = ds_map_create();


var a = 3;

