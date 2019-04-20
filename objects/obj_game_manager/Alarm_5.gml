if global.isPopulatingGrids || global.isUpdatingRoomLayers {
	// do not deactivate anything if we're populating grids rn
	alarm[5] = 1;
	exit;
}
// deactivate solid environment stuff outside of view every deactivationSteps frames
with obj_solid_environment {
	if neverDeactivate {
		instance_activate_object(id);
	} else {
		instance_deactivate_object(id);
	}
}

with obj_enemy_parent {
	if state != CombatantStates.Moving {
		instance_deactivate_object(id);
	}
}
// special case for noeyeddeer
with obj_enemy_noeyeddeer {
	instance_deactivate_object(id);
}

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
var w = vw + (2*deactivationBorder);
var h = vh + (2*deactivationBorder);
instance_activate_region(vx - deactivationBorder, vy - deactivationBorder, w, h, true);

/*
// may need to set / reset the personalGrid of combatants, if the combatants were not around during create event
with obj_combatant_parent {
	populatePersonalGrid();
}*/



instance_activate_object(obj_fountain);
alarm[5] = deactivationSteps;