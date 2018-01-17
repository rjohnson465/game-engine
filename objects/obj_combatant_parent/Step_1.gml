var canSee = canSeePlayer(id);
var s = state == CombatantStates.Idle;

if !canSeePlayer(id) && state == CombatantStates.Idle {
	visible = false;
} else visible = true;