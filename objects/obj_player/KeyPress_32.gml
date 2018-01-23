// dodge

var s = state == CombatantStates.Idle;
var s2 = state == CombatantStates.Moving;
var s3 = state == CombatantStates.Attacking;
var s4 = state == CombatantStates.Staggering;

if  stamina > 0 &&
	(state == CombatantStates.Idle || state == CombatantStates.Moving)
	&& !isFrozen
	{
	
	stamina-= 10;
	var UP = keyboard_check(ord("W"));
	var DOWN = keyboard_check(ord("S"));
	var LEFT = keyboard_check(ord("A"));
	var RIGHT = keyboard_check(ord("D"));
		
	if UP || DOWN || LEFT || RIGHT {
		dodgeDirection = direction;
	} else dodgeDirection = facingDirection;
	state = CombatantStates.Dodging;
	
	/*isPhasing = true;
	global.condition = "Phase";
	global.owner = id;
	instance_create_depth(x,y,1,obj_condition_particles);*/
} else if stamina < 0 {
	//isPhasing = false;
}