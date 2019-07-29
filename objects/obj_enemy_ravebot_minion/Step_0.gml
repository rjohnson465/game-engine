event_inherited();


if state != CombatantStates.Attacking && state != CombatantStates.AggroMelee {
	lockOnTarget = global.player;
	currentMeleeAttack = 0;
	state = CombatantStates.Attacking;
} 

rotatingDir += 3;
facingDirection = rotatingDir;

hp -= 1/room_speed;
