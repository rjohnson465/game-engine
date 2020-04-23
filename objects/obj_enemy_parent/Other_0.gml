if !isAlive exit;
path_end();
x = postX; 
y = postY;
layer = layer_get_id("instances_floor_" + string(getLayerFloorNumber(postZ)))
lockOnTarget = noone;
state = CombatantStates.Idle;