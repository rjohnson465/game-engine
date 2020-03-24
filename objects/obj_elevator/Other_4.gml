if instance_number(obj_room_data) == 0 {
	 exit;
}

persistentElementUpdateProperties(id);

elevatorCurrentFloor = ds_map_find_value(properties, "ElevatorCurrentFloor");
elevatorFloorToMoveTo = elevatorCurrentFloor;
var floorLayerName = "instances_floor_" + string(elevatorCurrentFloor);
var floorLayer = layer_get_id(floorLayerName);
layer = floorLayer;
origLayer = layer;
depth = layer_get_depth(origLayer) + 5;

