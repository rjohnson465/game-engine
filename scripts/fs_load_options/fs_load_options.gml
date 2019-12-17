/// fs_load_options(optionsDataMap)
/// @param optionsDataMap
/// load options from game file

var sd_options = argument[0];
var cv = ds_map_find_first(sd_options);
for (var j = 0; j < ds_map_size(sd_options); j++) {
	
	var sd_optMap = ds_map_find_value(sd_options,cv);
	
	var oldMap = noone;
	with obj_options_manager {
		switch cv {
			case NAV_DISPLAY: {
				oldMap = optionsMapDisplay;
				optionsMapDisplay =  ds_map_deep_clone(sd_optMap);
				break;
			}
			case NAV_SOUND: {
				oldMap = optionsMapSound;
				optionsMapSound = ds_map_deep_clone(sd_optMap);
				break;
			}
			case NAV_GAMEPLAY: {
				oldMap = optionsMapGameplay;
				optionsMapGameplay = ds_map_deep_clone(sd_optMap);
				break;
			}
		}
	}
	ds_map_destroy(oldMap); oldMap = -1;
	
	cv = ds_map_find_next(sd_options,cv);
}
