/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

message = "Save Hershel from the first wave of dybbuks";

ghostSpawnPoints = [
	[350, 270],
	[855, 120]
];

GHOSTS_TO_SPAWN_COUNT = 1;
GHOST_SPAWN_STAGGER_RANGE = [90, 120];
ghostsSpawnedList = ds_list_create();
randomize();
alarm[0] = random_range(GHOST_SPAWN_STAGGER_RANGE[0], GHOST_SPAWN_STAGGER_RANGE[1]);