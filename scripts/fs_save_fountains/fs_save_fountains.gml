/// fs_save_fountains
/// returns a map of all the fountain data in the game
var sd_fountains = ds_map_create();
with obj_fountain_data {
	var sd_fountain = ds_map_create();
	
	ds_map_replace(sd_fountain,"postX",postX);
	ds_map_replace(sd_fountain,"postY",postY);
	ds_map_replace(sd_fountain,"isDoneFilling",isDoneFilling);
	
	var key = fs_generate_key(fountain);

	ds_map_add_map(sd_fountains,key,sd_fountain);
}

return sd_fountains;