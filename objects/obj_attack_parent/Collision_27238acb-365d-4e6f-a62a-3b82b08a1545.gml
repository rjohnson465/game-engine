// keep track of who this attack has hit -- attacks can only hit a combatant once by default
//ds_list_add(other.beenHitWith,id);
ds_list_add(combatantsHit,other.id);

/*if	(isRanged || (isSpell && spell.spriteName != "aoe"))
	&& 
	(owner.type == CombatantTypes.Player && other.type == CombatantTypes.Enemy
	|| owner.type == CombatantTypes.Ally && other.type == CombatantTypes.Enemy 
	|| owner.type == CombatantTypes.Enemy && other.type == CombatantTypes.Ally
	|| owner.type == CombatantTypes.Enemy && other.type == CombatantTypes.Player) 	
	&& other.state != CombatantStates.Dodging
	{
	instance_destroy(id,true);
}*/