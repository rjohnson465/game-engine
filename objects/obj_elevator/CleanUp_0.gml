/// @description Insert description here
// You can write your code in this editor
event_inherited();

if ds_exists(elevatorOccupants, ds_type_list) {
	ds_list_destroy(elevatorOccupants); elevatorOccupants = -1;
}