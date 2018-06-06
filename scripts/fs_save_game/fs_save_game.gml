/// saveGame

var save_data = ds_map_create();
var filename = "Game.sav";

// save the current room
// this must be loaded and the game manager must take us to this room before anything else can be loaded
//ds_map_replace(save_data,"Room",room_get_name(room));

// save player info
ds_map_add_map(save_data,"Player",fs_save_player());

// save fountain info
ds_map_add_map(save_data,"Fountains",fs_save_fountains());

// save enemy info
ds_map_add_map(save_data,"Enemies",fs_save_enemies());

// save inventory items
ds_map_add_map(save_data,"Inventory",fs_save_inventory());

// save to file name
ds_map_secure_save(save_data,filename);



