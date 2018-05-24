if instance_exists(owner) {
	if owner.isShowingLightRadius {
		x = owner.x;
		y = owner.y;
	} 
	if layer != global.player.layer {
		x = -10000;
		y = -10000;
	}
	var wallsBetweenTarget = scr_collision_line_list_layer(x,y,global.player.x,global.player.y,obj_wall_parent,true,true);
	if object_is_ancestor(owner.object_index,obj_combatant_parent) && owner != global.player && wallsBetweenTarget != noone {
		x = -10000; y = -10000;
	}
	if ds_exists(wallsBetweenTarget,ds_type_list) {
		ds_list_destroy(wallsBetweenTarget);
	}
}

