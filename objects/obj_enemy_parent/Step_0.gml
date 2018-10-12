event_inherited();

if state == CombatantStates.Moving && x != postX && y != postY {
	updatePersistentElementProperty(id,"CurrentX",x);
	updatePersistentElementProperty(id,"CurrentY",y);
	updatePersistentElementProperty(id,"CurrentZ",layer);
	updatePersistentElementProperty(id,"FacingDirection",facingDirection);
	updatePersistentElementProperty(id,"FacingDirectionStart",postDir);
}

