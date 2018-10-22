/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

switch state {
	case CombatantStates.Moving: {
		
		facingDirection = runningDirection;
		
		//moveToNearestFreePoint(runningDirection, functionalSpeed, 1,1);
		var xx = x+lengthdir_x(functionalSpeed,runningDirection);
		var yy = y+lengthdir_y(functionalSpeed,runningDirection);
		
		if place_meeting_layer(xx,yy,obj_solid_environment) {
			runningDirection = (runningDirection + 180) % 360;
		} else {
			x = xx; y = yy;
		}
		
		with obj_combatant_parent {
			if place_meeting_layer(x,y,other) {
				if !moveToNearestFreePoint(other.runningDirection,other.functionalSpeed,type==CombatantTypes.Enemy,0) {
					jumpToNearestFreePoint(type==CombatantTypes.Enemy,0);
				}
				if other.alarm[4] < 0 other.alarm[4] = 7;
				if other.alarm[4] == 1 {
					var damagesMap = ds_map_create();
					ds_map_replace(damagesMap,CRUSH,[2,5]);
					damageCombatant(damagesMap,2,other.runningDirection,snd_hit1,other);
				}
			}
		}
		
		break;
	}
	case CombatantStates.Idle: {
		state = CombatantStates.Moving; break;
	}
}