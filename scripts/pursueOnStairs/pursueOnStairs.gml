/// pursueOnStairs()
/// static method called by AI combatant when in Move state and PursueOnStairs substate
// gets combatant to then up or down stairs, depending on where their target went

var stairs = lockOnTarget.lastStairs;
if stairs.layer != layer {
	var closestDist = 1000; var closestStairs = noone;
	with obj_stairs {
		var dist = distance_to_object(stairs);
		if (dist < closestDist && layer == other.layer) {
			closestStairs = id; closestDist = dist;
		}
	}
	stairs = closestStairs;
}
var newLayerNum = real(string_copy(layer_get_name(layer),string_length(layer_get_name(layer)),1));
var minDir = newLayerNum == stairs.floorUp ? stairs.upDirectionMin : ((stairs.upDirectionMin+180)%360);
var maxDir = newLayerNum == stairs.floorUp ? stairs.upDirectionMax : ((stairs.upDirectionMax+180)%360);
// if we aren't at the stairs, try to go to the stairs
if distance_to_point(stairs.x,stairs.y) > 5 && !hasReachedMidStairs {
	if mp_grid_path(personalGrid,gridPath,x,y,stairs.x,stairs.y,1) {
		path_start(gridPath,functionalSpeed,path_action_stop,false);
	}
	else {
		// if there's no path to these stairs, just fuck off and go home
		path_end();
		populatePersonalGrid();
		substate = CombatantMoveSubstates.ReturningToPost;
	}
}
// if we've reached the stairs, go up or down them (depending on where our target went)
else {
	hasReachedMidStairs = true;
	if (place_meeting_layer(x,y,obj_enemy_stairs)) {
		var estairs = noone; var closestDist = 1000;
		with obj_enemy_stairs {
			var dist = distance_to_object(other);
			if dist < closestDist && layer == other.layer {
				closestDist = dist;
				estairs = id;
			}
		}
		// find some free point in the right direction and set a path to it
		var dir = (minDir + 90)%360; var factor = 10;
		var midX = estairs.x + (.5*(sprite_width*image_xscale)); var midY = estairs.y + (.5*(sprite_height)*image_yscale);
		var xx = midX + lengthdir_x(factor,dir); var yy = midY + lengthdir_y(factor,dir);
		while place_meeting(xx,yy,estairs) || !mp_grid_path(personalGrid,gridPath,x,y,xx,yy,1) {
			factor += 10;
			xx = midX + lengthdir_x(factor,dir); yy = midY + lengthdir_y(factor,dir);
		}
		mp_grid_path(personalGrid,gridPath,x,y,xx,yy,1);
		path_start(gridPath,functionalSpeed,path_action_stop,0);
	} 
			
}	


if hasReachedMidStairs && !place_meeting(x,y,obj_enemy_stairs) {
	path_end();
	populatePersonalGrid();
	substate = CombatantMoveSubstates.Chasing;
}