event_inherited();

var hershel = instance_nearest(x, y, obj_hershel);
if !isAggroed && instance_exists(hershel) {
	// draw beam from hands
	var beamSpr = spr_enemy_dybukkboss_beam_1_1_beam;
	var length = point_distance(x, y, hershel.x, hershel.y);
	
	var xx = x + lengthdir_x(15, facingDirection);
	var yy = y + lengthdir_y(10, facingDirection);
	
	draw_sprite_ext(beamSpr, 1, xx, yy, length, 1, facingDirection, c_white, .85);

	with beamLight {
		x = other.x; 
		y = other.y;
		_light_sprite = spr_light_square_midleft;
		_light_alpha = .75;
		_light_angle = other.facingDirection;
		
		randomize();
		var rand = random_range(.2, 1);
		_light_yscale = rand;
		_light_xscale = length / sprite_get_width(spr_light_square_midleft);
	}
	
	// also burst more particles at hit zone
	var xxx = xx + lengthdir_x(length, facingDirection);
	var yyy = yy + lengthdir_y(length, facingDirection);
	part_emitter_region(sporeSystem, sporeEmitter, xxx - 1, xxx + 1, yyy - 1, yyy + 1, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(sporeSystem, sporeEmitter, possessParticle, 4);
	

} else {
	beamLight.x = -1000;
	beamLight.y = -1000;
}