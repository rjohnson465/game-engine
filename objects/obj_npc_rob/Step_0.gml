/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var ele = instance_nearest(x, y, obj_elevator);
if ele.elevatorIsMoving {
	isInteractable = false;
} else {
	isInteractable = true;
}