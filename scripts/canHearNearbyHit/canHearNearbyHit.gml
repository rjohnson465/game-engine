/// canHearNearbyHit() 
/// returns the first heard hit particles if the enemy can hear a nearby hit; else return noone
/// must be called by obj_combatant child
with obj_hit_particles {
	/// does not pay attention to level up particles 
	if type == "LevelUp" continue;
	var distToHit = point_distance(other.x,other.y,x1,y1);
	// factor how many walls we're listening through
	var wallsBetweenTarget = scr_collision_line_list_layer(other.x,other.y,x1,y1,obj_wall_parent,true,true);
	if ds_exists(wallsBetweenTarget,ds_type_list) {
		for (var i = 0; i < ds_list_size(wallsBetweenTarget); i++) {
			var wall = ds_list_find_value(wallsBetweenTarget,i);
			if !place_meeting_layer(x1,y1,wall) && i > 0 {
				distToHit += 150;
			}
		}
		ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1; // mem leak
	}
	
	if distToHit < other.hearingDistance {
		return id;
	}
}
return noone;