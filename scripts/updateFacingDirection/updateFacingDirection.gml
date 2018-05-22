//if global.isInteractingWithNpc exit;
var isInteractingWithNpc = false;
with obj_npc_parent {
	if isInteractingWithPlayer isInteractingWithNpc = true;
}

if global.isWishing exit;
if global.isInteractingWithNpc || isInteractingWithNpc exit;

if state != CombatantStates.Staggering && !isMouseInMenu && !global.ui.isShowingMenus && !isInteractingWithNpc {
	// player faces mouse if not locked on
	if state == CombatantStates.Idle || state == CombatantStates.Moving 
	|| (ds_map_size(preparingLimbs)!=0)
	{
		if gamepad_is_connected(gamePadIndex) {
			var h_point = gamepad_axis_value(gamePadIndex, gp_axisrh);
			var v_point = gamepad_axis_value(gamePadIndex, gp_axisrv);
			if ((h_point != 0) || (v_point != 0))
			{
				var pdir = point_direction(0, 0, h_point, v_point);
				var dif = angle_difference(pdir, facingDirection);
				facingDirection += median(-45, dif, 45);
				facingDirection = (facingDirection+360)%360;
			}
		} else {
			var pdir = point_direction(x,y,mouse_x,mouse_y);
			var dif = angle_difference(pdir, facingDirection);
			facingDirection += median(-45, dif, 45);
			facingDirection = (facingDirection+360)%360;
		}
	}
	// otherwise, player always faces locked on enemy
	if isLockedOn {
		facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
	}
}