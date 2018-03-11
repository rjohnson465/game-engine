var udMin = upDirectionMin;
var udMax = upDirectionMax;
var fu = floorUp;
var fd = floorDown;
if place_meeting_layer(x,y,obj_player) {
	with obj_player {
		var layerName = layer_get_name(layer);
		var layerNum = real(string_char_at(layerName, string_length(layerName)));
	
		if angleBetween(udMin,udMax,direction) && climbingDir != "u" {
			layerToChangeTo = layer_get_id("instances_floor_" + string(fu));
			climbingDir = "u";
		} 
	
		else if !angleBetween(udMin,udMax,direction) && climbingDir != "d" {
			layerToChangeTo = layer_get_id("instances_floor_" + string(fd));
			climbingDir = "d";
		}
	}
}
