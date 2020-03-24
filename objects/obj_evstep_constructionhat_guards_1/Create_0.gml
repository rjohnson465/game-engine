/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

message = "Slay the unfairies";

enemyKeys = ["u1", "u2", "u3"];

eventListeners = ds_map_create();
ds_map_replace(eventListeners, EV_ENEMY_KILLED, scr_evl_ev_constructionhat_guards_killed);