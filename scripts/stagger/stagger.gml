var sspeed = staggerSpeed == noone ? normalSpeed : staggerSpeed;

if audio_emitter_exists(attackPrepSoundEmitter) {
	audio_emitter_gain(attackPrepSoundEmitter, 0);
	audio_emitter_free(attackPrepSoundEmitter); attackPrepSoundEmitter = -1;
}

if staggerFrame == 1 {
	// reset poise at the start of a stagger
	poiseCurrent = poiseMax;
}
		
if staggerDuration > 30 staggerDuration = 30; // never stagger more than a full second
		
while staggerDirection < 0 {
	staggerDirection += 360;
}
staggerDirection = staggerDirection%360;
	
speed = 0;
var sDir = staggerDirection;
var isEnemy = type == CombatantTypes.Enemy;
direction = staggerDirection;
// stagger twice as quickly early on
var solidsToCheck = type == CombatantTypes.Enemy ? obj_enemy_obstacle_parent : obj_solid_parent;
/*if type == CombatantTypes.Player {
	solidsToCheck = scr_get_ids_region(obj_solid_parent, x-200, y-200, x+200, y+200);
}*/
if (staggerFrame > .5*staggerDuration) {	
	var x1 = x+lengthdir_x(.5*sspeed, sDir);
	var y1 = y+lengthdir_y(.5*sspeed, sDir);
	do {
		x1 = x+lengthdir_x(.5*sspeed, sDir);
		y1 = y+lengthdir_y(.52*sspeed, sDir);
		//var _pml = place_meeting_layer(x1,y1,solidsToCheck);
		//var _pml2 = place_meeting_layer(x1,y1,obj_combatant_parent);
		if place_meeting_layer(x1,y1,solidsToCheck) || place_meeting_layer(x1,y1,obj_combatant_parent) {
			sDir = (sDir + 22.5)%360;
			/*if sDir == staggerDirection {
				
				//var _pml = place_meeting_layer(x1,y1,solidsToCheck);
				//var _pml2 = place_meeting_layer(x1,y1,obj_combatant_parent);
				//var a = 3;
			}*/
		}
	} until ((!place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent)) || sDir == staggerDirection)
			
	//if !place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent) {
		moveToNearestFreePoint(sDir,.25*sspeed,isEnemy);
		staggerDirection = sDir;
	//}
} else {
			
	var x1 = x+lengthdir_x(.25*sspeed, sDir);
	var y1 = y+lengthdir_y(.25*sspeed, sDir);
			
	do {
		x1 = x+lengthdir_x(.25*sspeed, sDir);
		y1 = y+lengthdir_y(.25*sspeed, sDir);
		//var _pml = place_meeting_layer(x1,y1,solidsToCheck);
		//var _pml2 = place_meeting_layer(x1,y1,obj_combatant_parent);
		if place_meeting_layer(x1,y1,solidsToCheck) || place_meeting_layer(x1,y1,obj_combatant_parent) {
			sDir = (sDir + 22.5)%360;
		}
	} until ((!place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent)) || sDir == staggerDirection)
			
	//if !place_meeting_layer(x1,y1,solidsToCheck) && !place_meeting_layer(x1,y1,obj_combatant_parent) {
		moveToNearestFreePoint(sDir,.5*sspeed,isEnemy);
		staggerDirection = sDir;

	//}
			
}
staggerFrame++;