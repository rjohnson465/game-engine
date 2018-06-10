/// fs_save_skills
/// returns a map of all skills
var sd_skills = ds_map_create();
with obj_skill_parent {
	var sd_skill = ds_map_create();
	
	ds_map_replace(sd_skill,"Level",level);
	
	var key = object_get_name(object_index);

	ds_map_add_map(sd_skills,key,sd_skill);
}

return sd_skills;