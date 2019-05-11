/*if instance_number(obj_room_data) == 0 {
	 exit;
}
persistentElementUpdateProperties(id);
elevatorCurrentFloor = ds_map_find_value(properties, "ElevatorCurrentFloor");
*/
elevatorCurrentFloor = getLayerFloorNumber(layer);
elevatorFloorToMoveTo = elevatorCurrentFloor;