/// maybeInvestigate()
/// what a combatant does when he reaches an investigation point (a point where he heard some noise)

investigatingFrame++;

// wander around this point
if alarm[6] == -1 alarm[6] = 30;

if isInvestigatingMoving {
	moveToNearestFreePoint(investigatingDirection,functionalSpeed*.5,1);
	facingDirection = direction;
}
