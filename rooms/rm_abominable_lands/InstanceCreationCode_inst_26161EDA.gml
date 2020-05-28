enemiesLeft = 3;
eventKeys = ["gank1", "gank2", "gank3"];
roomStartScript = scr_abominiongate_roomstart;
ds_map_replace(eventListeners, EV_ENEMY_KILLED, scr_evl_abominiongate_check);