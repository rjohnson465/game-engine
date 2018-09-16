var sspeed = staggerSpeed == noone ? functionalSpeed : staggerSpeed;
		
while staggerDirection < 0 {
	staggerDirection += 360;
}
staggerDirection = staggerDirection%360;
	
speed = 0;
var sDir = staggerDirection;
direction = staggerDirection;
// stagger twice as quickly early on
var solidsToCheck = type == CombatantTypes.Enemy ? obj_enemy_obstacle_parent : obj_solid_parent;
if (staggerFrame > .5*staggerDuration) {	
	var x1 = x+lengthdir_x(.5*sspeed, sDir);
	var y1 = y+lengthdir_y(.5*sspeed, sDir);
	do {
		x1 = x+lengthdir_x(.5*sspeed, sDir);
		y1 = y+lengthdir_y(.52*sspeed, sDir);
		var _pml = place_meeting_layer(x1,y1,solidsToCheck);
		var _pml2 = place_meeting_layer(x1,y1,obj_combatant_parent);
		if place_meeting_layer(x1,y1,solidsToCheck) || place_meeting_layer(x1,y1,obj_combatant_parent) {
			sDir = (sDir + 45)%360;
			if sDir == staggerDirection {
				
				var _pml = place_meeting_layer(x1,y1,solidsToCheck);
				var _pml2 = place_meeting_layer(x1,y1,obj_combatant_parent);
				var a = 3;
			}
		}
	} until ((!place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent)) || sDir == staggerDirection)
			
	//if !place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent) {
		speed = .25*sspeed;
		staggerDirection = sDir;
	//}
	/*moveToNearestFreePoint(sDir, .25*sspeed,1);
	staggerDirection = sDir;*/
} else {
			
	var x1 = x+lengthdir_x(.25*sspeed, sDir);
	var y1 = y+lengthdir_y(.25*sspeed, sDir);
			
	do {
		x1 = x+lengthdir_x(.25*sspeed, sDir);
		y1 = y+lengthdir_y(.25*sspeed, sDir);
		if place_meeting_layer(x1,y1,solidsToCheck) || place_meeting_layer(x1,y1,obj_combatant_parent) {
			sDir = (sDir + 45)%360;
		}
	} until ((!place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent)) || sDir == staggerDirection)
			
	//if !place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent) {
		speed = .5*sspeed;
		staggerDirection = sDir;
	//}
			
}
staggerFrame++;