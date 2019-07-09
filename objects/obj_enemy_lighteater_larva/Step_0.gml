event_inherited();

var me = id;
with obj_fairylight {
	
	
	
	if origLayer == other.layer && distance_to_object(other) < 200 {
		
		// which larva is closest? only use that one to determine light alpha
		var closestLarva = noone; var closestDist = 1000;
		with obj_enemy_lighteater_larva {
			if layer == other.origLayer && distance_to_object(other) < 200 {
				var dist = distance_to_object(other);
				if dist < closestDist {
					closestLarva = id;
					closestDist = dist;
				}
			}
		}
		
		if closestLarva == me {
			with lightRadius {
				var a = ((1/300)*closestDist) + (1/12);
				light_set_alpha(a);
			}
		}
	}
}