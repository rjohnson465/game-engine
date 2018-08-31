/// startInvestigation()
/// enemy has heard a nearby hit sound, starts to go looking for the source
var hit = canHearNearbyHit();
global.owner = id;
var dir = (hit.particleDirection+180)%360;
var x1 = hit.x1 + lengthdir_x(50,dir); var y1 = hit.y1 + lengthdir_y(50,dir);
var target = instance_create_depth(x1,y1,1,obj_temp_lockontarget);
lockOnTarget = target;
state = CombatantStates.Moving;