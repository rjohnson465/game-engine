prepareLayerShader();
alpha = 1;
scale = 1;
// fairies float
if isFairy || isFloating {
	scale = .1*cos((pi*floatingFrame)/30)+.9; // normal floating
} 
if state == CombatantStates.Moving {
	updateMoveSpriteAndImageSpeed();
	draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, facingDirection, c_white, alpha);
} else {
	draw_sprite_ext(sprite_index, 1, x, y, scale, scale, facingDirection, c_white, alpha);
}

if isFairy {
	floatingFrame += 1;
	floatingFrame = floatingFrame % 60;
}

with obj_light_radius {
	if owner == other.id {
		light_set_scale(other.lightRadiusScale*other.scale);
	}
}

shader_reset();