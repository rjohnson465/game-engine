// on room start, create an instance of obj_room_data if there is not one fot this room yet
var roomDataObj = noone;
with obj_room_data {
	if roomIndex == room {
		roomDataObj = id;
	}
}

if roomDataObj == noone {
	instance_create_depth(x,y,1,obj_room_data);
}

if layerToMoveTo != noone {
	layer = layer_get_id(layerToMoveTo);
}

// handles layer shading
updateRoomLayers();


/*
// assign proper solid_floor_x parents to all solid objects

// get sorted list of all solid elements, sorted by their current layer
var solids = ds_list_create();
with obj_solid_parent {
	var layerName = layer_get_name(layer);
	var key = layerName+"_"+string(id);
	ds_list_add(solids,key);
}
ds_list_sort(solids,true);

// iterate over sorted list, setting parent to proper solid_floor_x index
for (var i = 0; i < ds_list_size(solids); i++) {
	var key = ds_list_find_value(solids,i);
	//var underscorePos = string_pos(key,"_");
	var instance = real(string_delete(string_digits(key),1,1));
	
	var layerName = layer_get_name(instance.layer);
	var layerNum = real(string_char_at(layerName,string_length(layerName)));
	
	// find the parent that is obj_solid_parent, then change it to the asset at parentString
	var objectParentName = "";
	var objectName = "";
	var objectParentIndex = -4;
	var objIndex = object_index;
	do  {
		objectName = object_get_name(objIndex);
		objectParentIndex = object_get_parent(objIndex);
		objectParentName = object_get_name(objectParentIndex);
		if objectParentName != "obj_solid_parent" {
			objIndex = objectParentIndex;
		}
	} until objectParentName == "obj_solid_parent"
	
	// set objectIndex's parent to proper floor solid
	var floorSolidIndex = asset_get_index("obj_solid_floor_"+string(layerNum));
}

var layerName = layer_get_name(layer);
	var layerNum = real(string_char_at(layerName,string_length(layerName)));
	var parentString = "obj_solid_floor_"+string(layerNum);
	
	// find the parent that is obj_solid_parent, then change it to the asset at parentString
	var objectName = object_get_name(object_index);
	var objectParentIndex = object_get_parent(object_index);
	var objectParentName = object_get_name(objectParentIndex);
	var a = 3;*/