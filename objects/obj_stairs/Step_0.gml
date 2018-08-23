var udMin = upDirectionMin;
var udMax = upDirectionMax;
var fu = floorUp;
var fd = floorDown;
if place_meeting_layer(x,y,global.player) {
	with global.player {
		var layerName = layer_get_name(layer);
		var layerNum = real(string_char_at(layerName, string_length(layerName)));
		
		//var dir = point_direction(xprevious,yprevious,x,y);
		var dir = point_direction(other.x,other.y,x,y);
		//show_debug_message(dir);
		if angleBetween(udMin,udMax,dir) && climbingDir != "u" {
			layerToChangeTo = layer_get_id("instances_floor_" + string(fu));
			climbingDir = "u";
		} 
	
		else if !angleBetween(udMin,udMax,dir) && climbingDir != "d" {
			layerToChangeTo = layer_get_id("instances_floor_" + string(fd));
			climbingDir = "d";
		}
	}
}
