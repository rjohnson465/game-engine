// flinching just moves you back a little in a given direction
// its like staggering but doesnt interrupt attacks
isStrafing = false;
if flinchFrame < totalFlinchFrames {
	var fspeed = flinchSpeed == 0 ? functionalSpeed : flinchSpeed;
	
	speed = 0;
	direction = flinchDirection;
	while flinchDirection < 0 {
		flinchDirection += 360;
	}
	flinchDirection = flinchDirection%360;
	// stagger twice as quickly early on
	var fDir = flinchDirection;
	var solidsToCheck = type == CombatantTypes.Enemy ? obj_enemy_obstacle_parent : obj_solid_parent;
	if (flinchFrame > .5*totalFlinchFrames) {
			
		var x1 = x+lengthdir_x(.25*fspeed, fDir);
		var y1 = y+lengthdir_y(.25*fspeed, fDir);
		do {
			x1 = x+lengthdir_x(.25*fspeed, fDir);
			y1 = y+lengthdir_y(.25*fspeed, fDir);
			if place_meeting_layer(x1,y1,solidsToCheck) || place_meeting_layer(x1,y1,obj_combatant_parent) {
				fDir = (fDir + 45)%360;
			}
		} until ((!place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent)) || fDir == flinchDirection)
			
		if !place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent) {
			speed = .1*fspeed;
			flinchDirection = fDir;
		}
	} else {
		var x1 = x+lengthdir_x(.5*fspeed, fDir);
		var y1 = y+lengthdir_y(.5*fspeed, fDir);
			
		do {
			x1 = x+lengthdir_x(.25*fspeed, fDir);
			y1 = y+lengthdir_y(.25*fspeed, fDir);
			if place_meeting_layer(x1,y1,solidsToCheck) || place_meeting_layer(x1,y1,obj_combatant_parent) {
				fDir = (fDir + 45)%360;
			}
		} until ((!place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent)) || fDir == flinchDirection)
			
		if !place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent) {
			speed = .2*fspeed;
			flinchDirection = fDir;
		}
	}
	flinchFrame++;
} else {
	flinchFrame = 0;
	totalFlinchFrames = 0;
	isFlinching = false;
	flinchSpeed = 0;
}