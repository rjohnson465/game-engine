/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var ele = instance_nearest(x, y, obj_elevator);
var floorLayerName = "instances_floor_" + string(ele.elevatorCurrentFloor);
var lay = layer_get_id(floorLayerName);
if lay != layer {
	layer = lay;
}