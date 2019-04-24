/// @description Insert description here
// You can write your code in this editor
if instance_number(object_index) > 1 exit;
if global.gameEnding exit;
// Inherit the parent event
event_inherited();

ds_map_destroy(inventoryCapacityMap); inventoryCapacityMap = -1;
if ds_exists(temporaryDefenses, ds_type_list) {
	ds_list_destroy(temporaryDefenses); temporaryDefenses = -1;
}