var udMin = upDirectionMin;
var udMax = upDirectionMax;
var fu = floorUp;
var fd = floorDown;
if place_meeting_layer(x,y,obj_combatant_parent) {
	var combatantsInside = scr_get_ids_region(obj_combatant_parent,bbox_left,bbox_top,bbox_right,bbox_bottom);
	
	for (var i = 0; i < ds_list_size(combatantsInside); i++) {
		with ds_list_find_value(combatantsInside,i) {
			var layerName = layer_get_name(layer);
			var layerNum = real(string_char_at(layerName, string_length(layerName)));
	
			if angleBetween(udMin,udMax,direction) && climbingDir != "u" {
				/*var upperLayer = layer_get_id("instances_floor_" + string(layerNum+1));
				if upperLayer != -1 {
					layerToChangeTo = upperLayer;
					show_debug_message("changing up to " + layer_get_name(upperLayer));
				} else layerToChangeTo = layer;*/
				layerToChangeTo = layer_get_id("instances_floor_" + string(fu));
				climbingDir = "u";
			} 
	
			else if !angleBetween(udMin,udMax,direction) && climbingDir != "d" {
				/*var lowerLayer = layer_get_id("instances_floor_"+ string(layerNum-1));
				if lowerLayer != -1 {
					show_debug_message("changing down to " + layer_get_name(lowerLayer));
					layerToChangeTo = lowerLayer;
				} else layerToChangeTo = layer;*/
				layerToChangeTo = layer_get_id("instances_floor_" + string(fd));
				climbingDir = "d";
			}
		}
	}
}
