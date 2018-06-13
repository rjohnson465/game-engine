/// fs_load_roomdata(roomDataMap)
/// @param fountainsDataMap
/// creates fountains data objects from save game file

/*
with obj_room_data {
	instance_destroy(id,1);
}*/

/*
with obj_persistent_environment_data_parent {
	instance_destroy(id,1);
}*/

var sd_roomdatas = argument[0];
var ck = ds_map_find_first(sd_roomdatas); 
for (var i = 0; i < ds_map_size(sd_roomdatas); i++) {
	
	var sd_roomdata = ds_map_find_value(sd_roomdatas,ck);
	
	var roomDataObj = noone;
	with obj_room_data {
		var __roomIndex = roomIndex;
		var __roomIndexIsCk = roomIndex == ck;
		if string(roomIndex) == ck {
			roomDataObj = id;
		}
	}
	if roomDataObj == noone {
		roomDataObj = instance_create_depth(x,y,1,obj_room_data);
		ds_map_clear(roomDataObj.persistentElements);
	}
	
	roomDataObj.roomIndex = ck;
	
	// populate persistent elements map
	var ckk = ds_map_find_first(sd_roomdata); 
	var prevckk = noone;
	var px = noone; var py = noone;
	var elObj = noone; // the data object
	for (var j = 0; j < ds_map_size(sd_roomdata); j++) {
		var sd_el_map = ds_map_find_value(sd_roomdata, ckk);
		var objIndexName = ds_map_find_value(sd_el_map, "ObjectIndexName");
		
		with obj_persistent_environment_data_parent {
			if key == ckk elObj = id;
		}
		if elObj == noone {
			global.el = noone; // el does not exist yet!
			elObj = instance_create_depth(x,y,1,asset_get_index(objIndexName));
			elObj.key = ckk;
			elObj.roomIndex = ck;
			// elObj.el WILL BE NOONE
		}
		
		elObj.postX = ds_map_find_value(sd_el_map, "PostX");
		elObj.postY = ds_map_find_value(sd_el_map, "PostY");
		px = elObj.postX; py = elObj.postY;
		
		// set all properties
		var propsMap = ds_map_find_value(sd_el_map, "Properties");
		var ckkk = ds_map_find_first(propsMap);
		for (var k = 0; k < ds_map_size(propsMap); k++) {
			var val = ds_map_find_value(propsMap, ckkk);
			ds_map_replace(elObj.properties, ckkk, val);
			ckkk = ds_map_find_next(propsMap, ckkk);
		}
		
		prevckk = ckk;
		
		// set the data object -- NEED TO DO THIS ON EACH DATA OBJECT
		if prevckk != undefined && prevckk != noone {
			var elObjIndexName = prevckk;
			var firstCutIndex = noone; var secondCutIndex = noone;
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
			var obj = findPersistentRoomElement(asset_get_index(elObjIndexName),px,py);
			if obj != noone {
				with obj {
					data = elObj;
					elObj.el = obj;
				
					with obj_light_radius {
						if owner == obj {
							instance_destroy(id,1);
						}
					}
				
					event_perform(ev_other, ev_room_start); // since we've now enforced the binding between element / element data, update
				}
			}
		}
		
		
		
		ckk = ds_map_find_next(sd_roomdata, ckk);
	}
	
	
	
	ck = ds_map_find_next(sd_roomdatas,ck);
}

/*
// destroy all current fountain data objs
with obj_fountain_data {
	instance_destroy(id,1);
}

var sd_fountains = argument[0];
var cv = ds_map_find_first(sd_fountains);
for (var i = 0; i < ds_map_size(sd_fountains); i++) {
	
	var sd_fountain = ds_map_find_value(sd_fountains,cv);
	
	var fountainDataObj = noone;
	with obj_fountain_data {
		if key == cv fountainDataObj = id;
	} 
	if fountainDataObj == noone fountainDataObj = instance_create_depth(x,y,1,obj_fountain_data);
	
	fountainDataObj.key = cv;
	fountainDataObj.postX = ds_map_find_value(sd_fountain,"postX");
	fountainDataObj.postY = ds_map_find_value(sd_fountain,"postY");
	fountainDataObj.isDoneFilling = ds_map_find_value(sd_fountain,"isDoneFilling");
	
	// might need to hard-set the fountain being on and give it its light radius
	with obj_fountain {
		if key == cv {
			fountainData = fountainDataObj;
			if fountainDataObj.isDoneFilling {
				sprite_index = asset_get_index("spr_fountain_full");
				isDoneFilling = true;
				isRunning = true;
				with obj_light_radius {
					if owner == other.id {
						instance_destroy(id,1);
					}
				}
				global.owner = id;
				global.makeLightOnCreate = true;
				instance_create_depth(x,y,1,obj_light_radius);
			}
		}
	}
	
	cv = ds_map_find_next(sd_fountains,cv);
}