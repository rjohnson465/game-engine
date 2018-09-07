/// maybeAggroRanged()
/// Just does a check to see if we can/should aggro ranged (can see lockOnTarget and is in ranged range). Returns true if so.
// check if in ranged aggro range
if canSeeLockOnTarget() && rangedAggroRange != noone && distance_to_object(lockOnTargetType) < rangedAggroRange {
	//lockOnTarget = noone;
	state = CombatantStates.AggroRanged;
	onAlert = false;
	return true;
}
return false;