enemiesLeft = 1;
eventKeys = ["f1-1"];
roomStartScript = scr_abominiongate_roomstart;
ds_map_replace(eventListeners, EV_ENEMY_KILLED, scr_evl_abominiongate_check);