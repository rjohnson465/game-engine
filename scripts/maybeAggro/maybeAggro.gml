/// maybeAggro()
if lockOnTarget != noone && lockOnTarget.layer != layer return false;
/// check if AI combatant should enter an Aggro state at this moment. Can be Ranged or Melee. Returns true if so.
if	((canSeeLockOnTarget() || (lockOnTarget != noone && substate != CombatantMoveSubstates.TraverseStairs)) && meleeAggroRange != noone && distance_to_object(lockOnTargetType) < meleeAggroRange)	{
	//lockOnTarget = noone;
	state = CombatantStates.AggroMelee;
	onAlert = false;
	return true;
}
else if (canSeeLockOnTarget() || (lockOnTarget != noone && substate != CombatantMoveSubstates.TraverseStairs)) && rangedAggroRange != noone && distance_to_object(lockOnTargetType) < rangedAggroRange {
	//lockOnTarget = noone;
	state = CombatantStates.AggroRanged;
	onAlert = false;
	return true;
} else return false;