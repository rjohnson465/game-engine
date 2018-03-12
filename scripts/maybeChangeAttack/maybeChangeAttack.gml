// if combatant was going to use a melee attack but their target is out of range and combatant has ranged attacks, switch to a ranged attack
if currentMeleeAttack && distance_to_object(lockOnTarget) > meleeAggroRange && array_length_1d(rangedAttacks) > 0 {
	state = CombatantStates.AggroRanged;
	return true;
	//break;
}
// vice versa
else if currentRangedAttack && distance_to_object(lockOnTarget) < meleeAggroRange && array_length_1d(meleeAttacks) > 0 {
	state = CombatantStates.AggroMelee;
	return true;
	//break;
}
return false;