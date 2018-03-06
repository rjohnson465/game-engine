var udMin = upDirectionMin;
var udMax = upDirectionMax;
with other {
	var layerName = layer_get_name(layer);
	var layerNum = real(string_char_at(layerName, string_length(layerName)));
	//var lBound = ((udMax+180)%360);
	//if lBound == 0 lBound = 360;
	var b = angleBetween(udMin,udMax,direction);
	
	if /*direction > udMin && direction < udMax(*/angleBetween(udMin,udMax,direction) && climbingDir != "u" {
		var upperLayer = layer_get_id("instances_floor_" + string(layerNum+1));
		if upperLayer != -1 {
			layerToChangeTo = upperLayer;
			show_debug_message("changing up to " + layer_get_name(upperLayer));
		} else layerToChangeTo = layer;
		climbingDir = "u";
	} 
	
	else if /*direction < lBound && direction > udMax*/!angleBetween(udMin,udMax,direction) && climbingDir != "d" {
		var lowerLayer = layer_get_id("instances_floor_"+ string(layerNum-1));
		if lowerLayer != -1 {
			show_debug_message("changing down to " + layer_get_name(lowerLayer));
			layerToChangeTo = lowerLayer;
		} else layerToChangeTo = layer;
		climbingDir = "d";
	}
}
