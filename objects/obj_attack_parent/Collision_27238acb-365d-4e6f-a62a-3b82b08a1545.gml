// keep track of who this attack has hit -- attacks can only hit a combatant once by default
ds_list_add(other.beenHitWith,id);
ds_list_add(combatantsHit,other.id);