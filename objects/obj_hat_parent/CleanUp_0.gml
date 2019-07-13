/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if ds_exists(defenses, ds_type_map) {
	ds_map_destroy(defenses); defenses = -1;
}

if variable_instance_exists(id, "specialHatDefenses") && ds_exists(specialHatDefenses, ds_type_map) {
	ds_map_destroy(specialHatDefenses); specialHatDefenses = -1;
}

if variable_instance_exists(id, "specialHatProperties") && ds_exists(specialHatProperties, ds_type_map) {
	ds_map_destroy(specialHatProperties); specialHatProperties = -1;
}