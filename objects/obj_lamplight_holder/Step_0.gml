event_inherited();

if hasSetAlarm && instance_exists(lightRadius) {
	with lightRadius {
		var alpha = 1 - (1/other.fadeLightFrame);
		if other.fadeLightFrame < 0 {
			alpha = 0;
		}
		light_set_alpha(alpha);
		other.fadeLightFrame--;
	}
}