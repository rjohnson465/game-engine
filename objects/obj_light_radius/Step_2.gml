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
	
	if object_is_ancestor(owner.object_index,obj_combatant_parent) && owner != global.player && !owner.isBurning {
		x = -1000; y = -1000;
	}

	
}

