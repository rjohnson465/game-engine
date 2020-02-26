shader_reset();
var isTakingDamge = false;
if isActive && !isGoingToAri && !isWithAri {
	with obj_enemy_dybukk {
		// if isAggroed continue;
		if layer != other.layer continue;
		if distance_to_object(other) < 25 {
			isTakingDamge = true;
		}
	}
}

if isTakingDamge {
	shader_set(sh_red);
	var uPOSITION = shader_get_uniform(sh_red, "Position");
	shader_set_uniform_f(uPOSITION, global.gameManager.selectedItemFilterAlpha); 
}

draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,c_white,1);
shader_reset();

/*
draw_set_alpha(.25);
mp_grid_draw(grid);

draw_set_alpha(1);
draw_set_color(c_aqua);
draw_path(gridPath, x, y, true);