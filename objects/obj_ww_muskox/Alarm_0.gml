// maybe walk
randomize();
var rand = random_range(0,1);
if rand < .5 {
	direction = random_range(0,360);
	state = CombatantStates.Moving;
} else {
	speed = 0;
	state = CombatantStates.Idle;
}

alarm[0] = 90;