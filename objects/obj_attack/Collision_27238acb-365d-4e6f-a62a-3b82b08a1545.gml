// keep track of who this attack has hit -- attacks can only hit a combatant once by default
if other.id != owner.id && other.type == owner.lockOnTargetType {
	ds_list_add(combatantsHit,other.id);
}