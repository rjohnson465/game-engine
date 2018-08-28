/// fs_load_skills(skillsDataMap)
/// @param skillsDataMap
/// creates skills from save game file

// no need to destroy -> create skills -- if a player instance is active, all skill objs exist

var sd_skills = argument[0];
var cv = ds_map_find_first(sd_skills);
for (var j = 0; j < ds_map_size(sd_skills); j++) {
	
	var sd_skill = ds_map_find_value(sd_skills,cv);
	var skillObj = asset_get_index(cv);
	
	with skillObj {
		level = ds_map_find_value(sd_skill,"Level");
		// level up this skill "Level" no. of times
		for (var i = 0; i < level; i++) {
			isLevelingUp = true;
			event_perform(ev_step,ev_step_normal);
		}
	}
	
	cv = ds_map_find_next(sd_skills,cv);
}

ds_map_destroy(sd_skills); sd_skills = -1;