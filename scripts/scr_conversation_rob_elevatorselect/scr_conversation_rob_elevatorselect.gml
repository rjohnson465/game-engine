/// scr_conversation_rob_elevator()
/// called by rob

owner.isInteractingWithPlayer = false;
owner.isInConversation = false;
owner.showBuySell = false;
global.isInteractingWithNpc = false;
global.isTrading = false;

global.elevatorSelectNumFloors = 3; 
global.elevatorStartFloor = 1;
// TODO
// If lamplight factory quest is at or past step where all wires are found, add floor 4
// If the hidden fourth wire is found, add Floor 0 (to Winter Wonderground)

var llfWiresStep = instance_nearest(x, y, obj_queststep_llf_1);
if (llfWiresStep.status == QuestStepStatus.Completed) {
	global.elevatorSelectNumFloors = 4;
}

var llfQuest = instance_nearest(x, y, obj_quest_llf);
if llfQuest.isFinished {
	global.elevatorStartFloor = 0;
}

instance_create_depth(x, y, depth, obj_elevator_floor_select);