/// startInvestigation()
/// enemy has heard a nearby hit sound, starts to go looking for the source
var hit = canHearNearbyHit();
global.owner = id;
var dir = (hit.particleDirection+180)%360;
var x1 = hit.x1 + lengthdir_x(50,dir); var y1 = hit.y1 + lengthdir_y(50,dir);
investigationPtX = x1; investigationPtY = y1;
state = CombatantStates.Moving;
substate = CombatantMoveSubstates.Investigating;