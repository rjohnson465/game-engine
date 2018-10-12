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
// reset all layer shader objects
with obj_layer_shader {
	surface_free(surface_canvas_1);
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
			// also don't show fountains or sconces with depth near depth of this layer
			with obj_fountain {
				var lDepth = layer_get_depth(l);
				var diff = abs(lDepth - depth);
				if diff < 5 {
					visible = false;
				}
			}
			with obj_sconce {
				var lDepth = layer_get_depth(l);
				var diff = abs(lDepth - depth);
				if diff < 5 {
					visible = false;
				}
			}
			with obj_solid_environment {
				if origLayer == l {
					visible = false;
				}
			}
		}
		// make visible layers at or below player's layer
		// draw layers below a little darker, use a Shader
		else {
			layer_set_visible(l,true);
			with obj_fountain {
				var lDepth = layer_get_depth(l);
				var diff = abs(lDepth - depth);
				if diff < 5 {
					visible = true;
				}
			}
			with obj_sconce {
				var lDepth = layer_get_depth(l);
				var diff = abs(lDepth - depth);
				if diff < 5 {
					visible = true;
				}
			}
			// depth needs to be average of tiles layer and instances layer for this floor
			var tilesLayer = layer_get_id("tiles_floor_" + string(lNum));
			var instancesLayer = layer_get_id("instances_floor_" + string(lNum));
			var depth1 = layer_get_depth(tilesLayer);
			var depth2 = layer_get_depth(instancesLayer);
			var d = mean(depth1,depth2);
			
			global.shaderInstanceLayer = instancesLayer;
			global.floorNum = lNum;
			instance_create_depth(x,y,d,obj_layer_shader);

		}
	}
}

with obj_enemy_obstacle_parent {
	if layer == playerLayer {
		solid = true;
	} else if !isObstacleLayerless {
		solid = false;
	}
	
	/*if object_index == obj_fountain && origLayer == playerLayer {
		solid = true;
	} else if object_index == obj_fountain && origLayer != playerLayer {
		solid = false;
	}*/
	if object_is_ancestor(object_index, obj_solid_environment) {
		if origLayer == playerLayer {
			solid = true;
		} else solid = false;
	}
	
	if object_index == obj_enemy_parent solid = false;
	
	if object_index == obj_player {
		solid = false;
	}
}

// this will make enemies avoid fallzones when walking, but lets them dodge into them
with obj_fallzone {
	/*if layer == playerLayer {
		solid = true;
	} else solid = false;*/
}
ds_list_destroy(instanceLayersAbove); instanceLayersAbove = -1;
ds_list_destroy(tileLayersAbove); tileLayersAbove = -1;

with obj_weapon {
	refreshParticles = true;
}