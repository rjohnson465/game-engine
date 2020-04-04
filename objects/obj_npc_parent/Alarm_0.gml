// maybe walk
if !wanders exit;
randomize();
var rand = random_range(0,1);
if rand < .5 {
	direction = random_range(0,360);
	//speed = normalSpeed;
	state = CombatantStates.Moving;
} else {
	speed = 0;
	state = CombatantStates.Idle;
}

alarm[0] = 90;