/// saveGame

var save_data = ds_map_create();
var filename = "Game.sav";

// save player info

// save fountain info
ds_map_add_map(save_data,"Fountains",fs_save_fountains());

// save enemy info
ds_map_add_map(save_data,"Enemies",fs_save_enemies());

// save to file name
ds_map_secure_save(save_data,filename);



