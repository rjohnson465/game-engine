if status != ExerciseStepStatus.InProgress exit;

// This step is done when player either moves or interacts with Barry
var p = global.player;
var barry = instance_nearest(x, y, obj_npc_barry);
if !instance_exists(barry) exit;
if barry.isInConversation || p.xprevious != p.x || p.yprevious != p.y {
	status = ExerciseStepStatus.Completed;
}

