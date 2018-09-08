if instance_exists(owner) {
	if object_is_ancestor(owner.object_index, obj_combatant_parent) && owner.hp < 1 {
		x = -1000; y = -1000;
	}
	else if owner.object_index == obj_weapon && owner.limbItem.baseName == "Torch" {
		randomize(); 
		var rand = random_range(.8,1);
		light_set_scale(rand);
		//randomize();
		//var rand2 = random_range(.25,.5);
		
		light_set_alpha(1);
		exit;
	}
	else if owner.isShowingLightRadius {
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
		ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
	}
}

