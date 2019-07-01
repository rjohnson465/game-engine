/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if part_system_exists(partSystemLighteater) {
	if part_emitter_exists(partSystemLighteater, partEmiLighteater) {
		part_emitter_destroy(partSystemLighteater, partEmiLighteater); partEmiLighteater = -1;
	}
	
	part_system_destroy(partSystemLighteater); partSystemLighteater = -1;
}

if part_type_exists(partLamplightHeal) {
	part_type_destroy(partLamplightHeal); partLamplightHeal = -1;
}

if ds_exists(stopEatingDamageAttacksList, ds_type_list) {
	ds_list_destroy(stopEatingDamageAttacksList); stopEatingDamageAttacksList = -1;
}