/// @description Insert description here
// You can write your code in this editor

// light stuff
if attackData != noone && attackData.hasLightRadius {
	// update light radius angle (if turning)
	_light_angle = image_angle;

	// maybe update light radius scale
	if attackData.lightRadiusScalesByFrame != noone && is_array(attackData.lightRadiusScalesByFrame) {
		var frame = round(image_index);
		if array_length_1d(attackData.lightRadiusScalesByFrame) > frame {
			var entry = attackData.lightRadiusScalesByFrame[frame];
			
			// multi-scale case
			if is_array(entry) {
				var xs = entry[0];
				var ys = entry[1];
				_light_xscale = xs;
				_light_yscale = ys;
			}
			// single scale case
			else {
				var scale = entry;
				_light_scale = scale;
				_light_xscale = scale;
				_light_yscale = scale;
			}
			
		}
	}

}