shader_reset();
if hasSetAlarm exit;
scale = .1*cos((pi*floatingFrame)/30)+.9; // normal floating
with lightRadius {
	light_set_scale(other.scale * other.lightRadiusScale);
}
draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, rotAngle, c_white, .75);

floatingFrame += 1;
floatingFrame = floatingFrame % 60;
rotAngle += 5;
rotAngle = rotAngle % 360;

