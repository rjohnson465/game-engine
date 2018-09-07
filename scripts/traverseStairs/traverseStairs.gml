/// traverseStairs(stairsObject, isGoingUp)
/// @param stairsObject -- the actual stairs object (not enemy_stairs)
/// @param isGoingUp
// used by AI combatant to go up or down stairs

var stairs = argument[0];
var isGoingUp = argument[1];
var isGoingDown = !isGoingUp;

// the enemy_stairs object closest to the stairs object and on our layer
var estairs = noone; var closestDist = 1000;
with obj_enemy_stairs {
	var dist = distance_to_object(stairs);
	if dist < closestDist && layer == other.layer {
		estairs = id;
		closestDist = dist;
	}
}

// the min/max dir to move to go up or down the stairs
var minDir = isGoingUp ? stairs.upDirectionMin : ((stairs.upDirectionMin+180)%360);
var maxDir = isGoingUp ? stairs.upDirectionMax : ((stairs.upDirectionMax+180)%360);

// the direction we're gonna move to traverse these stairs in the correct manner
var dir = (minDir + 90)%360; 

// the midpoint of the enemy_stairs object
var esw = estairs.sprite_width*estairs.image_xscale;
var esh = estairs.sprite_height*estairs.image_yscale;
var midX = estairs.x + (.5*esw); var midY = estairs.y + (.5*esh);
	
// get two points this combatant must path to, if they are unset (only happens on first step of this function)
// the first point is where the climb / descent begins
// the second point is where the climb / descent ends
if stairsBeginPtX == noone {
	path_end();
	stairsBeginPtX = stairs.x;//midX + lengthdir_x(.5*esw,(dir+180)%360);
	stairsBeginPtY = stairs.y;//midY + lengthdir_y(.5*esh,(dir+180)%350);
	// TODO the second point must be a little bit away from the actual stairs object
	//stairsEndPtX = midX + lengthdir_x(.5*esw,dir);
	//stairsEndPtY = midY + lengthdir_y(.5*esh,dir);
	stairsEndPtX = stairsBeginPtX + 200;
	stairsEndPtY = stairs.y;
	/*var factor = 10;
	var xx = midX + lengthdir_x(factor,dir); var yy = midY + lengthdir_y(factor,dir);
	while place_meeting(xx,yy,estairs) || !mp_grid_path(personalGrid,gridPath,x,y,xx,yy,1) {
		factor += 10;
		xx = midX + lengthdir_x(factor,dir); yy = midY + lengthdir_y(factor,dir);
	}
	stairsEndPtX = xx; stairsEndPtY = yy;*/
	mp_grid_path(personalGrid, gridPath,x,y,stairsBeginPtX, stairsBeginPtY,1);
	path_add_point(gridPath,stairsEndPtX,stairsEndPtY,100);
	path_start(gridPath,functionalSpeed,path_action_stop,1);
}

if distance_to_point(stairsEndPtX,stairsEndPtY) < 5 {
	if lockOnTarget != noone {
		path_end();
		stairsBeginPtX = noone; stairsBeginPtY = noone;
		//stairsEndPtX = noone; stairsEndPtY = noone;
		investigationPtX = stairsEndPtX; investigationPtY = stairsEndPtY;
		stairsResetClimb = true;
		populatePersonalGrid();
		substate = CombatantMoveSubstates.Investigating;
	}
}

populatePersonalGrid();
/*
// if we've reached the first point, mark that
if is_real(stairsBeginPtX) && distance_to_point(stairsBeginPtX,stairsBeginPtY) < 2 {
	path_end();
	stairsBeginPtX = "Done"; stairsBeginPtY = "Done";
}

// if we haven't reached the first point yet, path to there
if stairsBeginPtX != "Done" {
	if mp_grid_path(personalGrid,gridPath,x,y,stairsBeginPtX,stairsBeginPtY,1) {
		path_start(gridPath,functionalSpeed,path_action_stop,false);
	}
	else {
		// if there's no path to these stairs, just fuck off and go home
		path_end();
		stairsBeginPtX = noone; stairsBeginPtY = noone;
		//stairsEndPtX = noone; stairsEndPtY = noone;
		populatePersonalGrid();
		substate = CombatantMoveSubstates.ReturningToPost;
	}
}
// we have reached the first point, travel to the second point
else {
	
	mp_grid_path(personalGrid,gridPath,x,y,stairsEndPtX,stairsEndPtY,1);
	path_start(gridPath,functionalSpeed,path_action_stop,1);
}

// if we reach the second point, we start investigating
if stairsBeginPtX == "Done" && distance_to_point(stairsEndPtX,stairsEndPtY) < 2 {
	// if we were previously chasing someone, look around for them at the top of the stairs
	if lockOnTarget != noone {
		path_end();
		stairsBeginPtX = noone; stairsBeginPtY = noone;
		//stairsEndPtX = noone; stairsEndPtY = noone;
		investigationPtX = stairsEndPtX; investigationPtY = stairsEndPtY;
		populatePersonalGrid();
		substate = CombatantMoveSubstates.Investigating;
	}
}

