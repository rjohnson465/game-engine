// reassess current melee attack every 15 frames if in attack range for current melee attack

if	type != CombatantTypes.Player 
	&& state == CombatantStates.Moving && substate == CombatantMoveSubstates.Chasing
	&& lockOnTarget != noone && instance_exists(lockOnTarget) 
	&& currentMeleeAttack != noone && distance_to_object(lockOnTarget) <= getRangeForAttackIndex(currentMeleeAttack, 1)
	{
		chooseMeleeAttack();
}
alarm[0] = 15;