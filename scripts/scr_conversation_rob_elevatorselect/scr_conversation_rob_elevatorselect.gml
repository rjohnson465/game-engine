/// scr_conversation_rob_elevator()
/// called by rob

owner.isInteractingWithPlayer = false;
owner.isInConversation = false;
owner.showBuySell = false;
global.isInteractingWithNpc = false;
global.isTrading = false;

global.elevatorSelectNumFloors = 3; // TODO 
instance_create_depth(x, y, depth, obj_elevator_floor_select);