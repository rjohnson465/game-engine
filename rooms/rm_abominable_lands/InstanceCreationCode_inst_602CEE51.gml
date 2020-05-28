enemiesLeft = 1;
eventKeys = ["f2-guard", "f2-guard-2"]; // either one will open the gate
roomStartScript = scr_abominiongate_roomstart;
ds_map_replace(eventListeners, EV_ENEMY_KILLED, scr_evl_abominiongate_check);