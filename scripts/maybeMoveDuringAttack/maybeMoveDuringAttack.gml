// move forward while attacking with a melee attack (if not simultaenously preparing another attack)
if ds_map_size(attackingLimbs) != 0 {
	var attackingMelee = currentMeleeAttack != noone;
	if ds_map_size(preparingLimbs) == 0 {
		var x1 = x + lengthdir_x(2,facingDirection);
		var y1 = y + lengthdir_y(2,facingDirection);

		if attackingMelee && !place_meeting_layer(x1,y1,obj_solid_parent) {
			moveToNearestFreePoint(facingDirection,1);
		} else {
			speed = 0;
		}
	} else {
		speed = 0;
	}
}