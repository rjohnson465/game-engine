/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

message = "Slay the golems to escape";

enemyKeys = ["golem1", "golem2"];

golemsSlain = 0;
GOLEMS_TO_SLAY_COUNT = array_length_1d(enemyKeys);

eventListeners = ds_map_create();
ds_map_replace(eventListeners, EV_ENEMY_KILLED, scr_evl_ev_golemattack_golemkilled);