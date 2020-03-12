/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

message = "Slay dybukks before they possess hershel";

ghostSpawnPoints = [
	[1855, 2340],
	[2480, 2335],
	[1877 , 2889 ],
	[2450,2892]
];

GHOSTS_TO_SPAWN_COUNT = 8;
GHOST_SPAWN_STAGGER_RANGE = [120, 200];
GHOST_TIME_TO_DEAGGRO = 250;
ghostsSpawnedList = ds_list_create();
randomize();
alarm[0] = 15;