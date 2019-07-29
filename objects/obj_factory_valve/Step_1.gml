//scale = .1*cos((pi*floatingFrame)/30)+.9; // normal floating
//scale *= .3;
floatingFrame += 1;
floatingFrame = floatingFrame % 30;

if floatingFrame >= 15 {
	scale = 0;
} else {
	scale = .3;
}

if isActive {
	light_set_alpha(.75);
	light_set_color(c_lime);
	light_set_scale(.3);
} else {
	light_set_scale(scale);
	light_set_alpha(.5);
	light_set_color(c_red);
}

