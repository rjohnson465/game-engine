depth = -2000;
event = global.event;
name = "Event step";
message = "Event step message";

enum EventStepStatus {
	Unstarted,
	InProgress,
	Completed
}

status = ExerciseStepStatus.Unstarted;

// key/value --> <goal_name><value>
parameters = ds_map_create(); 

isFinalStep = false;

messageTopLeftX = noone;
messageTopLeftY = noone;
messageBottomRightX = noone;
messageBottomRightY = noone;
