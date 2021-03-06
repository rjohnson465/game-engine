///light_draw_layer(x, y, additive, shadows, blur_amount, layer)
/*
Draws the lights and shadows. It makes sense to only draw the surface at 0, 0 if you are not using view or view_xview, view_yview if you are.
x: The x location to draw the shadow map.
y: The y location to draw the shadow map.
additive: Whether to use additive blending or not.
shadows: Whether or not to draw shadows.
blur_amount: How blurry to make the shadows, numbers from 0 to 1 are good but you can go higher for more blurriness.
Blurry shadows generally makes a lower quality lightmap look nicer without the extra memory required for a full quality lightmap.
Important note: The object calling this function should have a lower depth than the casters.
*/




var layerNum = argument5;

var map = ds_map_find_value(global._light_layers,layerNum);
var _light_time = ds_map_find_value(map,"_light_time");
var _light_max_time = ds_map_find_value(map,"_light_max_time");
var _light_map = ds_map_find_value(map,"_light_map");
var _light_quality = ds_map_find_value(map,"_light_quality");
var _light_height = ds_map_find_value(map,"_light_height");
//var _light_color_main = ds_map_find_value(map,"_light_color");
var _light_color_main = lightColor; 
var _lights = ds_map_find_value(map,"_lights");
var _light_size = ds_map_find_value(map,"_light_size");
var _light_half_size = ds_map_find_value(map,"_light_half_size");
var _light_width = ds_map_find_value(map,"_light_width");
var _light_map = ds_map_find_value(map,"_light_map");
var _light_surface = ds_map_find_value(map,"_light_surface");
var _light_casters = ds_map_find_value(map,"_light_casters");

_light_time += delta_time
if _light_time >= _light_max_time
{
    _light_time = 0
    if !surface_exists(_light_map) {
        _light_map = surface_create(_light_width * _light_quality, _light_height * _light_quality)
		ds_map_replace(map,"_light_map",_light_map);
		ds_map_replace(global._light_layers,layerNum,map);
    }
    surface_set_target(_light_map)
    draw_clear(c_white)
    gpu_set_blendmode(bm_normal)
    draw_clear(_light_color_main)
    surface_reset_target()
 
    // Draw lights.
    for (var i = 0; i < ds_list_size(_lights); i++) {
		
        var _light = ds_list_find_value(_lights, i)
		
		if instance_exists(_light) {
			
			// do not draw light radius for player if player is invisible (i.e. in snow tunnel)
			if _light == global.player.playerLightRadius && !global.player.visible {
				continue;
			}
			
			var doNotDraw = false;
			with _light {
				if variable_instance_exists(id, "onlyDrawLightOnPlayerLayer") && onlyDrawLightOnPlayerLayer {
					var lay = variable_instance_exists(id, "origLayer") ? origLayer : layer;
					if lay != global.player.layer {
						doNotDraw = true;
					}
				}
			}
			
			if doNotDraw continue;

			// don't draw lights outside the view
			var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
			var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);
			if !point_in_rectangle(_light.x,_light.y,vx-500,vy-500,vx+vw+500,vy+vh+500) continue; 
			
			if _light.x < 0 || _light.y < 0 continue; // don't draw displaced lights
		}
		
        with _light {
			
			if object_index == obj_dybukk_beamlight {
				var a = 3;
			}
			
            var _light_left, _light_top, _light_right, _light_bottom;
            if sprite_get_xoffset(_light_sprite) != sprite_get_width(_light_sprite) / 2 && sprite_get_yoffset(_light_sprite) != sprite_get_height(_light_sprite) / 2 {
                _light_left = x - _light_size / 2
                _light_top = y - _light_size / 2
                _light_right = _light_left + _light_size
                _light_bottom = _light_top + _light_size
            }
            else {
                _light_left = x - _light_max_dist / 2
                _light_top = y - _light_max_dist / 2
                _light_right = _light_left + _light_max_dist
                _light_bottom = _light_top + _light_max_dist
            }

            var _light_inside = rectangle_in_rectangle(_light_left, _light_top, _light_right, _light_bottom, 
                argument0, argument1, argument0 + _light_width, argument1 + _light_height) > 0
            if _light_inside {
                if !_light_shadows {
                    surface_set_target(_light_map)
                    gpu_set_blendmode(bm_add)
                    draw_sprite_ext(_light_sprite, 0, (x - argument0) * _light_quality, (y - argument1) * _light_quality, _light_scale * _light_quality, _light_scale * _light_quality, _light_angle, _light_color, _light_alpha)
                    gpu_set_blendmode(bm_normal)
                    surface_reset_target()
                }
                else {
                    if !surface_exists(_light_surface) {
                        _light_surface = surface_create(_light_size * _light_quality, _light_size * _light_quality)
						ds_map_replace(map,"_light_surface",_light_surface);
						ds_map_replace(global._light_layers,layerNum,map);
                    }
                    surface_set_target(_light_surface)
                    draw_clear(c_black)
					var xs = _light_scale; var ys = _light_scale;
					if _light_is_multiscaled {
						xs = _light_xscale; ys = _light_yscale;
					}
					// draw lights below player brighter 
					var a = _light_alpha;
					var playerLayerNum = getLayerFloorNumber(global.player.layer);
					if layerNum < playerLayerNum && a > .01 {
						a += .5;
						if a > 1 a = 1;
					}
                    draw_sprite_ext(_light_sprite, 0, _light_half_size * _light_quality, _light_half_size * _light_quality, 
                        xs * _light_quality, ys * _light_quality, _light_angle, _light_color, a)
                    if argument3 {
                        // Draw shadows.
                        for (var j = 0; j < ds_list_size(_light_casters); j++) {
                            var _caster = ds_list_find_value(_light_casters, j)
                            with _caster {
								//if _caster.layer != other.layer continue;
                                if rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, _light_left, _light_top, _light_right, _light_bottom) {
                                    draw_primitive_begin(pr_trianglestrip)
                                    var points_cast_x, points_cast_y, points_start_x, points_start_y;
                                    // Draw all the cast points.
                                    for(var k = 0; k < array_length_1d(_light_points_x); k++) {
                                        if image_angle != 0 {
                                            points_start_x[k] = x + lengthdir_x(_light_points_x[k] * image_xscale, image_angle) - lengthdir_y(_light_points_y[k] * image_yscale, image_angle)
                                            points_start_y[k] = y + lengthdir_y(_light_points_x[k] * image_xscale, image_angle) + lengthdir_x(_light_points_y[k] * image_yscale, image_angle)
                                        }
                                        else {
                                            points_start_x[k] = x + _light_points_x[k] * image_xscale
                                            points_start_y[k] = y + _light_points_y[k] * image_yscale
                                        }
                                        var dir = point_direction(other.x, other.y, points_start_x[k], points_start_y[k]);
                                        points_cast_x[k] = points_start_x[k] + lengthdir_x(other._light_max_dist+1000, dir)
                                        points_cast_y[k] = points_start_y[k] + lengthdir_y(other._light_max_dist+1000, dir)
                                        
                                        draw_vertex_colour((points_start_x[k] - (other.x - _light_half_size)) * _light_quality, (points_start_y[k] - (other.y - _light_half_size)) * _light_quality, c_black, 1)
                                        draw_vertex_colour((points_cast_x[k] - (other.x - _light_half_size)) * _light_quality, (points_cast_y[k] - (other.y - _light_half_size)) * _light_quality, c_black, 1)
                                    }                                    
                                    draw_vertex_colour((points_start_x[0] - (other.x - _light_half_size)) * _light_quality, (points_start_y[0] - (other.y - _light_half_size)) * _light_quality, c_black, 1)
                                    draw_vertex_colour((points_cast_x[0] - (other.x - _light_half_size)) * _light_quality, (points_cast_y[0] - (other.y - _light_half_size)) * _light_quality, c_black, 1)

                                    // Draw the outline of the shadow.
                                    // If you don't plan on your lights going "behind" the casters, commenting this loop out is a small optomiztation.
                                    for(var k = 0; k < array_length_1d(_light_points_x); k++) {                                       
                                        draw_vertex_colour((points_cast_x[k] - (other.x - _light_half_size)) * _light_quality, (points_cast_y[k] - (other.y - _light_half_size)) * _light_quality, c_black, 1)
                                        draw_vertex_colour((points_cast_x[0] - (other.x - _light_half_size)) * _light_quality, (points_cast_y[0] - (other.y - _light_half_size)) * _light_quality, c_black, 1)
                                    }                                      

                                    draw_primitive_end()
                                }
                            }
                        }
                    }
                    surface_reset_target()
    
                    surface_set_target(_light_map)
                    draw_set_alpha(1)
                    draw_set_color(c_white)
                    gpu_set_blendmode(bm_add)
                    if surface_exists(_light_surface) {
                        draw_surface(_light_surface, (x - _light_half_size - argument0) * _light_quality, (y - _light_half_size - argument1) * _light_quality)
						//ds_map_replace(map,"_light_surface",_light_surface);
						//ds_map_replace(global._light_layers,layerNum,map);
					}
                    gpu_set_blendmode(bm_normal)
                    surface_reset_target()
                }
            }
        }
    }
}

if !argument2
    gpu_set_blendmode_ext(bm_dest_color, bm_zero)
else
    gpu_set_blendmode_ext(bm_dest_color, bm_src_color)

if surface_exists(_light_map)
{
    if argument4 <= 0
       draw_surface_ext(_light_map, argument0, argument1, 1 / _light_quality, 1 / _light_quality, 0, c_white, 1)
    else
        draw_surface_blurred(_light_map, argument0, argument1, 1 / _light_quality, 1 / _light_quality, argument4)
}
gpu_set_blendmode(bm_normal)