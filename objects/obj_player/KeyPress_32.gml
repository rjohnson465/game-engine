// dodge
if  stamina > 0 &&
	(state == CombatantStates.Idle || state == CombatantStates.Moving) {
	
	stamina-= 10;
	var UP = keyboard_check(ord("W"));
	var DOWN = keyboard_check(ord("S"));
	var LEFT = keyboard_check(ord("A"));
	var RIGHT = keyboard_check(ord("D"));
		
	if UP || DOWN || LEFT || RIGHT {
		dodgeDirection = direction;
	} else dodgeDirection = facingDirection;
	state = CombatantStates.Dodging;
		
}