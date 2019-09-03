/// updateRoomLayers()

/// update what instance and tile layers are visible, based on the player's current layer

var playerLayer = global.player.layer;
var pLayerName = layer_get_name(playerLayer);
var pLayerNum = real(string_char_at(pLayerName,string_length(pLayerName)));

// make invisible instance and tile layers above the player's layer
var instanceLayersAbove = ds_list_create();
var tileLayersAbove = ds_list_create();

var layers = layer_get_all();


for (var i = 0; i < array_length_1d(layers); i++) {
	var l = layers[i];
	var lName = layer_get_name(l);
	if lName == "Background" break;
	var roomName = room_get_name(room);
	var l = layer_get_id(lName);
	var le = layer_exists(l);
	
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
				if !object_is_ancestor(object_index, obj_npc_parent) && origLayer == l {
					
					visible = false;
				}
			}
			with all {
				if !object_is_ancestor(object_index, obj_npc_parent) && variable_instance_exists(id, "origLayer") {
					if origLayer == l {
						visible = false;
					}
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
			with obj_solid_environment {
				if origLayer == l && (!object_is_ancestor(object_index, obj_wall_parent) && object_index != obj_wall_parent) {
					visible = true;
				}
			}
			with all {
				if variable_instance_exists(id, "origLayer") {
					if origLayer == l && object_get_visible(object_index) {
						visible = true;
					}
				}
			}
			
			global.floorNum = lNum;
			var layerLightingObj = instance_create_depth(x,y,1,obj_layer_lighting);
			/*with layerLightingObj {
				event_perform(ev_draw, 0);
			}*/
			
		}
	}
}

with obj_enemy_obstacle_parent {
	
	if layer == playerLayer || isObstacleLayerless {
		solid = true;
	}
	
	if object_is_ancestor(object_index, obj_solid_environment) {
		if origLayer == playerLayer || isObstacleLayerless {
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
	if layer == playerLayer {
		solid = true;
	} else solid = false;
}
ds_list_destroy(instanceLayersAbove); instanceLayersAbove = -1;
ds_list_destroy(tileLayersAbove); tileLayersAbove = -1;

with obj_weapon {
	refreshParticles = true;
}

var pDepth = layer_get_depth(global.player.layer);
with obj_environment_particles {
	if partDepth != pDepth {
		part_particles_clear(system1);
		if part_type_exists(particle1) {
			part_emitter_stream(system1, emitter1, particle1, 0);
		}
		part_particles_clear(system2);
		if part_type_exists(particle2) {
			part_emitter_stream(system2, emitter2, particle2, 0);
		}
	}
	else {
		var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
		if part_type_exists(particle1) {
			part_emitter_region(system1,emitter1,vx-1000,vx+2000,vy-2000,vy+2000,ps_shape_rectangle,ps_distr_linear); 
			part_emitter_stream(system1,emitter1,particle1,num1); 
			repeat(initNum1) {
				// part_system_update(system1);
				part_emitter_burst(system1, emitter1, particle1, num1);
			} 
		}
		if part_type_exists(particle2) {
			part_emitter_region(system2,emitter2,vx-1000,vx+2000,vy-2000,vy+2000,ps_shape_rectangle,ps_distr_linear); 
			part_emitter_stream(system2,emitter2,particle2,num2); 
			repeat(initNum2) {
				part_emitter_burst(system2, emitter2, particle2, num2);
				// part_system_update(system2);
			} 
		}
	}
}

// update the light radius layer of the player's torch, if they are wielding one


with obj_weapon {
	if owner == global.player && limbKey == "r" {
		with obj_light_radius {
			if owner == other {
				updateLightLayer2(id);
			}
		}
	}
}
