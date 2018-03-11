/// @description canSeePlayer(*id)
/// @param *id Id of the instance to check if can see player

// returns true if there are no walls between player and it 

var instance = id;
if argument_count == 1 {
	instance = argument[0];
}
var wallsBetweenPlayer = script_execute(scr_collision_line_list_layer,instance.x,instance.y,global.player.x,global.player.y,obj_wall_parent,true,true);
if wallsBetweenPlayer == noone && layer == global.player.layer {
	return true;
} else {
	if wallsBetweenPlayer != noone {
		ds_list_destroy(wallsBetweenPlayer);
	}
	return false;
}