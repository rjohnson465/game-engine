/// updateRoomLayers()

/// update what instance and tile layers are visible, based on the player's current layer

var playerLayer = global.player.layer;
var pLayerName = layer_get_name(playerLayer);
var pLayerNum = real(string_char_at(pLayerName,string_length(pLayerName)));
var pLayerDepth = layer_get_depth(playerLayer);

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
			//layer_set_visible(l,false);
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

with obj_enemy_obstacle_parent {
	if layer == playerLayer {
		solid = true;
	} else solid = false;
	if object_index == obj_player {
		solid = false;
	}
}
/*
with obj_wall_parent {
	if layer == playerLayer {
		light_create_caster();
	} else light_destroy_caster();
}