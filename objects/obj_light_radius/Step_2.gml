if instance_exists(owner) {
	if object_is_ancestor(owner.object_index, obj_combatant_parent) && (owner.hp < 1 || layer != global.player.layer) {
		x = -1000; y = -1000;
	}
	else if owner.object_index == obj_weapon && owner.limbItem.baseName == "Torch" {
		randomize(); 
		var rand = random_range(.8,1);
		light_set_scale(rand);
		var floorNum = getLayerFloorNumber(layer);
		light_set_alpha(calculateLightRadiusAlphaLayer(floorNum));
		
		if owner.owner.state == CombatantStates.Dodging || owner.owner.currentUsingSpell != noone {
			x = -1000; y = -1000;
		}
		
		exit;
	}
	else if owner.isShowingLightRadius {
		x = owner.x;
		y = owner.y;
	} 
	/*if layer != global.player.layer  {
		x = -10000;
		y = -10000;
	}*/
	var wallsBetweenTarget = scr_collision_line_list_layer(x,y,global.player.x,global.player.y,obj_wall_parent,true,true);
	var doorsBetweenTarget = scr_collision_line_list_layer(x,y,global.player.x,global.player.y,obj_door,true,true);
	if object_is_ancestor(owner.object_index,obj_combatant_parent) && owner != global.player && (wallsBetweenTarget != noone || doorsBetweenTarget != noone) {
		x = -10000; y = -10000;
	}
	if ds_exists(doorsBetweenTarget,ds_type_list) {
		ds_list_destroy(doorsBetweenTarget); doorsBetweenTarget = -1;
	}
	if ds_exists(doorsBetweenTarget,ds_type_list) {
		ds_list_destroy(doorsBetweenTarget); doorsBetweenTarget = -1;
	}
	
}

