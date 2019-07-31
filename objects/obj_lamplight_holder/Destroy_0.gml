event_inherited();

if hasSetAlarm && instance_exists(lightRadius) {
	instance_destroy(lightRadius); lightRadius = -1;
}

