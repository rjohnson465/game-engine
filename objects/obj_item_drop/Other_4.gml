if roomIndex == room {
	x = postX; y = postY; layer = layer_get_id("instances_floor_" + string(getLayerFloorNumber(postZ)));
	lightRadius.x = x;
	lightRadius.y = y;

} else {
	x = -1000; y = -1000;
}