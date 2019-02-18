/// @description Insert description here
// You can write your code in this editor
if instance_number(object_index) > 1 exit;
// Inherit the parent event
event_inherited();

//audio_emitter_free(sprintSoundEmitter); sprintSoundEmitter = -1;
ds_map_destroy(inventoryCapacityMap); inventoryCapacityMap = -1;