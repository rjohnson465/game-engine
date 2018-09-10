/// maybeAggro()
/// check if AI combatant should enter an Aggro state at this moment. Can be Ranged or Melee. Returns true if so.
if	((canSeeLockOnTarget() || lockOnTarget != noone) && meleeAggroRange != noone && (array_length_1d(rangedAttacks) == 0 || distance_to_object(lockOnTargetType) < meleeAggroRange))	{
	//lockOnTarget = noone;
	state = CombatantStates.AggroMelee;
	onAlert = false;
	return true;
}
else if (canSeeLockOnTarget() || lockOnTarget != noone) && rangedAggroRange != noone && distance_to_object(lockOnTargetType) < rangedAggroRange {
	//lockOnTarget = noone;
	state = CombatantStates.AggroRanged;
	onAlert = false;
	return true;
} else return false;