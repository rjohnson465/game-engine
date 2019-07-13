event_inherited();
if status != QuestStepStatus.InProgress exit;

var lodgeDoor = noone;
with obj_door {
	if variable_instance_exists(id, "doorKey") && doorKey == "wamdkDoor" {
		lodgeDoor = id;
	}
}

if lodgeDoor != noone && (lodgeDoor.alarm[0] > 0 || lodgeDoor.isOpen) {
	status = QuestStepStatus.Completed;
}
