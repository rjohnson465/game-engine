// move forward while attacking with a melee attack (if not simultaenously preparing another attack)
if ds_map_size(attackingLimbs) != 0 {
	var attackingMelee = 
		(ds_map_find_value(attackingLimbs,"l") && leftHandItem.subType == HandItemTypes.Melee)	||
		(ds_map_find_value(attackingLimbs,"r") && rightHandItem.subType == HandItemTypes.Melee)
	if ds_map_size(preparingLimbs) == 0 {
		x1 = x + lengthdir_x(2,facingDirection);
		y1 = y + lengthdir_y(2,facingDirection);

		if attackingMelee && !place_meeting_layer(x1,y1,obj_solid_parent) {
			/*direction = facingDirection;
			speed = 1;*/
			moveToNearestFreePoint(facingDirection,1);
		} else {
			speed = 0;
		}
	} else {
		speed = 0;
	}
}