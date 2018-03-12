// if we've not yet calculated if we'll dodge during this Move state, calculate that now
// this is calculated only once per move state
if !hasCalculatedWillDodge {
	randomize();
	var rand = random_range(1,100);
	willDodge = rand <= agility ? true : false;
	hasCalculatedWillDodge = true;
}