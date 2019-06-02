if valve != noone && instance_exists(valve) {
	isActive = valve.isActive;
}

if isActive && soundIndex == noone {
	soundIndex = audio_play_sound_at(soundOn, x,y,depth, 50, 150, 1, 1, 1);
}

if !isActive && soundIndex != noone {
	audio_stop_sound(soundIndex);
	soundIndex = noone;
}

// particles 
if isActive {
	
	var floorNum = getLayerFloorNumber(origLayer);
	var pFloorNum = getLayerFloorNumber(global.player.layer);
	if floorNum > pFloorNum exit;

	// place particles under the water
	var xo = 16; var yo = 25;
	var a = image_angle;
	var sx = x + xo; var sy = y + yo;
	var cx = x; var cy = y;
	var radians = (pi/180) * a;
	var cs = cos(radians);
	var sn = sin(radians);
	var nx = (cs * (sx - cx)) + (sn * (sy - cy)) + cx;
	var ny = (cs * (sy - cy)) - (sn * (sx - cx)) + cy;
	
	var xx = nx;
	var yy = ny;

	
	part_emitter_region(system, emitter, xx-5, xx + 5, yy-5, yy + 5, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(system, emitter, particle, 2);

}