/// maybeAggroMelee()
/// static function used by AI combatants a lot. Just does a check if we should aggro melee (can see lockOnTarget and is in melee range). Returns true if so
if	((canSeeLockOnTarget()) && meleeAggroRange != noone && distance_to_object(lockOnTargetType) < meleeAggroRange)	{
	//lockOnTarget = noone;
	state = CombatantStates.AggroMelee;
	onAlert = false;
	return true;
}
return false;