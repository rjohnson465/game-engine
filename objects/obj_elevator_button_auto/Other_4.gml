with obj_elevator {
	if elevatorName == other.associatedElevatorName {
		other.associatedElevator = id;
	}
}

if instance_exists(associatedElevator) {
	with associatedElevator {
		event_perform(ev_other, ev_room_start);
	}
	
	layer = associatedElevator.layer;
	origLayer = layer;
	depth += 4;
}