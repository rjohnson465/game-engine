event_inherited();
if status != QuestStepStatus.InProgress exit;

// most of this is handled in the event listener 

/*
var lodgeDoor = noone;
with obj_door {
	if variable_instance_exists(id, "doorKey") && doorKey == "wamdkDoor" {
		lodgeDoor = id;
	}
}

if lodgeDoor != noone && (lodgeDoor.alarm[0] > 0 || lodgeDoor.isOpen) {
	status = QuestStepStatus.Completed;
}
