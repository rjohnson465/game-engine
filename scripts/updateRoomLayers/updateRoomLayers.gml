/// updateRoomLayers()

/// update what instance and tile layers are visible, based on the player's current layer

var playerLayer = global.player.layer;
var pLayerName = layer_get_name(playerLayer);
var pLayerNum = real(string_char_at(pLayerName,string_length(pLayerName)));
var pLayerDepth = layer_get_depth(playerLayer);

// move objects above this level out of the way
/*
var a = layer_get_all();
for (var i = 0; i < array_length_1d(a); i++) {
	var l = a[i];
	var layerName = layer_get_name(l);
	if string_pos(layerName,"tiles") != 0 continue;
	var lDepth = layer_get_depth(l);
	var elements = layer_get_all_elements(l);
	// move all this shit away to avoid collisions and whatnot
	if l != playerLayer {
		for (var j = 0; j < array_length_1d(elements); j++) {
			var el = elements[j];
			el = layer_instance_get_instance(el);
			// definitely move fountains
			if !instance_exists(el) continue;
			if !instance_exists(el.object_index) continue;
			// if this layer is above player layer, move everything...
			if lDepth < pLayerDepth {
				if	el.object_index == obj_fountain
					|| el.object_index == obj_wall_parent 
					|| el.object_index == obj_stairs
					{
					el.x = -10000;
					el.y = -10000;
				}
				else if object_is_ancestor(el.object_index,obj_combatant_parent) {
					// TODO also hide enemies when returning to post
					if el.state == CombatantStates.Idle {
						el.x = -10000;
						el.y = -10000;
					}
				}
			}
			// ... else just move walls / stairs
			else {
				if	el.object_index == obj_wall_parent 
					|| el.object_index == obj_stairs
					{
					el.x = -10000;
					el.y = -10000;
				}
			}
		}
	} 
	// move all this shit to where its supposed to be (postX/postY)
	else {
		for (var j = 0; j < array_length_1d(elements); j++) {
			var el = elements[j];
			el = layer_instance_get_instance(el);
			if el == global.player continue;
			if !instance_exists(el) continue;
			if !instance_exists(el.object_index) continue;
			// move fountains / walls back to their post
			if	el.object_index == obj_fountain
				|| el.object_index == obj_wall_parent 
				|| el.object_index == obj_stairs
			{
				el.x = el.postX;
				el.y = el.postY;
			}
			// move Idle enemies back to their post
			else if object_is_ancestor(el.object_index,obj_combatant_parent) {
				//if el.state == CombatantStates.Idle {
					el.x = el.postX;
					el.y = el.postY;
				//}
			}
		}
	}
}*/

// make invisible instance and tile layers above the player's layer
var instanceLayersAbove = ds_list_create();
var tileLayersAbove = ds_list_create();

var layers = layer_get_all();
// reset all floortiles brightness objects
with obj_floortiles_brightness {
	instance_destroy(id,false);
}
for (var i = 0; i < array_length_1d(layers); i++) {
	var l = layers[i];
	var lName = layer_get_name(l);
	if string_pos("_floor_",lName) {
		var lNum = real(string_char_at(lName,string_length(lName)));
		// if this layer is some floor above the player, it is not visible
		if lNum > pLayerNum {
			layer_set_visible(l,false);
		}
		// make visible layers at or below player's layer
		// draw layers below a little darker, might need to use a Shader
		else {
			layer_set_visible(l,true);
			
			// depth needs to be average of tiles layer and instances layer for this floor
			var tilesLayer = layer_get_id("tiles_floor_" + string(lNum));
			var instancesLayer = layer_get_id("instances_floor_" + string(lNum));
			var depth1 = layer_get_depth(tilesLayer);
			var depth2 = layer_get_depth(instancesLayer);
			var d = mean(depth1,depth2);
			
			global.floorNum = lNum;
			instance_create_depth(x,y,d,obj_floortiles_brightness);

		}
	}
}