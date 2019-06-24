/// @description Insert description here
// You can write your code in this editor
ds_map_replace(persistentProperties, "IsBoss", isBoss);

// Inherit the parent event
event_inherited();
populatePersonalGrid();

if instance_number(obj_room_data) == 0 exit;
persistentElementUpdateProperties(id); 

if ds_map_find_value(persistentProperties, "IsBossKilledBefore") {
	isBossKilledBefore = true;
}

isAlive = ds_map_find_value(persistentProperties, "IsAlive");
if isAlive {
	isShowingLightRadius = true;
	x = ds_map_find_value(persistentProperties, "CurrentX");
	y = ds_map_find_value(persistentProperties, "CurrentY");
} else {
	x = -1000;
	y = -1000;
}
if true {
	hp = ds_map_find_value(persistentProperties, "Hp");
	if isBoss && isAlive {
		hp = maxHp;
		x = postX;
		y = postY;
	}
}


layer = ds_map_find_value(persistentProperties, "CurrentZ");
if layer == -1 {
	var pz = ds_map_find_value(persistentProperties, "PostZ");
	layer = pz;
}


var lr = noone; var oldLayer = noone;
with obj_light_radius {
	if owner == other {
		oldLayer = layer;
		lr = id;
	}
}
if lr != noone {
	updateLightLayer(lr,oldLayer,layer);
}

tempPostX = ds_map_find_value(persistentProperties, "TempPostX");
tempPostY = ds_map_find_value(persistentProperties, "TempPostY");
tempPostZ = ds_map_find_value(persistentProperties, "TempPostZ");
if !isBoss {
	facingDirection = ds_map_find_value(persistentProperties, "FacingDirection");
}
path_end();
state = CombatantStates.Idle;
currentMeleeAttack = noone; currentRangedAttack = noone;
