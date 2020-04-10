/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var floorNum = getLayerFloorNumber(layer);
personalGrid = ds_map_find_value(global.grids, floorNum);

var sh = instance_nearest(x,y, obj_quest_savingherbie);

if instance_exists(sh) && (sh.isFinished || sh.currentQuestStepIndex > 1) {
	x = tavernPostX;
	y = tavernPostY;
} else {
	x = wolfDenPostX;
	y = wolfDenPostY;
	facingDirection = 135;
}