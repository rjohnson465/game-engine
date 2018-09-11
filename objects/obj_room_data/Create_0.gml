roomIndex = string(room);

// this stores fountains, doors, chests, etc... 
// kvp -> <key, data_obj>
persistentElements = ds_map_create();

/*
with obj_persistent_environment_data_parent {
	if roomIndex == other.roomIndex {
		ds_map_replace(other.persistentElements, key, id);
	}
}*/

// try to load the room data persistent objects data from save file
var save_data = ds_map_secure_load(global.gameManager.currentSaveFile);
var loadFromFile = true;
if ds_exists(save_data,ds_type_map) {
	var room_datas = ds_map_find_value(save_data,"RoomData");
	if room_datas != undefined && ds_exists(room_datas,ds_type_map) {
		var room_data = ds_map_find_value(room_datas,roomIndex);
		
		if room_data != undefined && ds_exists(room_data,ds_type_map) {
			// loop through the data, keys are persistent element keys, values are maps
			// ck is current persistent object key
			var ck = ds_map_find_first(room_data);
			for (var i = 0; i < ds_map_size(room_data); i++) {
				var el_data = ds_map_find_value(room_data,ck);
				var objectIndexName = ds_map_find_value(el_data,"ObjectIndexName");
				var objectIndex = asset_get_index(objectIndexName);
				
				var postX = ds_map_find_value(el_data, "PostX");
				var postY = ds_map_find_value(el_data, "PostY");
				var properties = ds_map_find_value(el_data, "Properties");
				
				// get the object index name of the actual persistent object (not just the data object)
				var firstCutIndex = noone; var secondCutIndex = noone;
				var elObjIndexName = ck;
				for (var l = 0; l < string_length(elObjIndexName); l++) {
					if string_char_at(elObjIndexName,l) == ";" {
						if firstCutIndex == noone {
							firstCutIndex = l;
						} else if secondCutIndex == noone {
							secondCutIndex = l;
						}
					}
				}
				elObjIndexName = string_copy(elObjIndexName,firstCutIndex+1,secondCutIndex-firstCutIndex-1);
				var elObjIndex = asset_get_index(elObjIndexName);
				
				// the actual object in the room to assign data from file for
				var persistentObj = findPersistentRoomElement(elObjIndex,postX,postY);
				// create the data object
				global.el = persistentObj;
				var dataObj = instance_create_depth(x,y,1,obj_persistent_environment_data_parent);
				persistentObj.data = dataObj;
				
				// set the properties of the new dataObj
				if ds_exists(properties,ds_type_map) {
					var cp = ds_map_find_first(properties); // cp = current property
					for (var j = 0; j < ds_map_size(properties); j++) {
						var propVal = ds_map_find_value(properties,cp);
						ds_map_replace(dataObj.properties,cp,propVal);
						cp = ds_map_find_next(properties,cp);
					}
				}
				
				// add the newly created data object to the room_data object's list of persistent objects
				ds_map_replace(persistentElements,ck,dataObj);
				
				ck = ds_map_find_next(room_data,ck);
			}
			
			// do a final sweep and make sure there are no new persistent elements that weren't saved in data
			// this is only really an issue in development, or maybe if things get patched
			with obj_persistent_environment {
				if data == noone {
					global.el = id;
					var dataObj = instance_create_depth(x,y,1,obj_persistent_environment_data_parent);
					ds_map_replace(other.persistentElements,dataObj.key,dataObj);
					data = dataObj;
				}
			}
			
		} else loadFromFile = false;
		
	} else loadFromFile = false;
} else loadFromFile = false;

// if there is no data for this room saved...
if !loadFromFile {
	// create persistent data objects for every persistent element in the room
	with obj_persistent_environment {
		global.el = id;
		var dataObj = instance_create_depth(x,y,1,obj_persistent_environment_data_parent);
		ds_map_replace(other.persistentElements,dataObj.key,dataObj);
		data = dataObj;
	}
}

// now that all the persistent elements have their data either set or created, ensure their room start event fires after
with obj_persistent_environment {
	event_perform(ev_other,ev_room_start);
}