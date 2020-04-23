/// @description Insert description here
// You can write your code in this editor

attackFrequencyTotalFramesMeleeDefault = attackFrequencyTotalFramesMelee;
attackFrequencyTotalFramesRangedDefault = attackFrequencyTotalFramesRanged;

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
	
	if isBoss {
		x = postX;
		y = postY;
	}
	
} else {
	x = -1000;
	y = -1000;
}

hp = ds_map_find_value(persistentProperties, "Hp");
if isBoss && isAlive {
	hp = maxHp;
	x = postX;
	y = postY;
	
	with obj_enemy_parent {
		if isBoss {
			hp = maxHp;
			x = postX;
			y = postY;
			isAlive = true;
		}
	}
}


var initialLayer = layer;
layer = layer_get_id("instances_floor_" + string(ds_map_find_value(persistentProperties, "CurrentZ")));
if layer == -1 || isBoss {
	//var pz = ds_map_find_value(persistentProperties, "PostZ");
	var pz = postZ;
	layer = layer_get_id("instances_floor_"+ string(postZ));
	if !layer_exists(layer) {
		layer = initialLayer;
	}
	
}

//if isBoss {
//	layer = postZ;
//}


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
