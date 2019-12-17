/// fs_save_skills
/// returns a map of all options
var sd_options = ds_map_create();
with obj_options_manager {
	ds_map_add_map(sd_options, NAV_DISPLAY, ds_map_deep_clone(optionsMapDisplay));
	ds_map_add_map(sd_options, NAV_SOUND, ds_map_deep_clone(optionsMapSound));
	ds_map_add_map(sd_options, NAV_GAMEPLAY, ds_map_deep_clone(optionsMapGameplay));
}

return sd_options;