// set state to heal / eat, reset hunger frame
var acceptableStatesToTransitionFrom = 
[
	CombatantStates.Idle,
	CombatantStates.Moving,
	CombatantStates.Wary
];
// do not transition to Eat state unless in an OK state for a transition
// i.e. do not transition to Eat state mid-attack
if !arrayIncludes(acceptableStatesToTransitionFrom, state) {
	alarm[2] = 1; 
	exit;
}
state = "Eat";
randomize();
alarm[2] = round(random_range(HUNGER_FRAME_MIN, HUNGER_FRAME_MAX));