/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
populatePersonalGrid();

persistentElementUpdateProperties(id);
isAlive = ds_map_find_value(persistentProperties, "IsAlive");
if isAlive {
	isShowingLightRadius = true;
	x = ds_map_find_value(persistentProperties, "CurrentX");
	y = ds_map_find_value(persistentProperties, "CurrentY");
} else {
	x = -1000;
	y = -1000;
}
hp = ds_map_find_value(persistentProperties, "Hp");
		
layer = ds_map_find_value(persistentProperties, "CurrentZ");
tempPostX = ds_map_find_value(persistentProperties, "TempPostX");
tempPostY = ds_map_find_value(persistentProperties, "TempPostY");
facingDirection = ds_map_find_value(persistentProperties, "FacingDirection");
