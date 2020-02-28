if isActive {
	light_set_alpha(.75);
	
	if associatedElevator.elevatorCurrentFloor == floorNum {
		isActive = false;
	}
} else {
	light_set_alpha(.25);
}
