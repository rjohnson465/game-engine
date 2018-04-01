// move forward while attacking with a melee attack (if not simultaenously preparing another attack)
if ds_map_size(attackingLimbs) != 0 {
	var attackingMelee = 
		(ds_map_find_value(attackingLimbs,"l") && leftHandItem.subType == HandItemTypes.Melee)	||
		(ds_map_find_value(attackingLimbs,"r") && rightHandItem.subType == HandItemTypes.Melee)
		
	if ds_map_size(preparingLimbs) == 0 {
		var x1 = x + lengthdir_x(2,facingDirection);
		var y1 = y + lengthdir_y(2,facingDirection);

		if attackingMelee && !place_meeting_layer(x1,y1,obj_solid_parent) {
			// get in range of shortest range weapon, iff both are melee and we have a lock on target
			var weaponL = ds_map_find_value(equippedLimbItems,"l");
			var weaponR = ds_map_find_value(equippedLimbItems,"r");
			var r = weaponL.range > weaponR.range ? weaponR.range : weaponL.range;
			var distanceToTarget = distance_to_object(lockOnTarget);
			if lockOnTarget != noone && distance_to_object(lockOnTarget) > r/2 {
				var dirToTarget = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
				moveToNearestFreePoint(dirToTarget,functionalSpeed);
			} else {
				moveToNearestFreePoint(facingDirection,functionalSpeed);
			}
		} else {
			speed = 0;
		}
	} else {
		speed = 0;
	}
}