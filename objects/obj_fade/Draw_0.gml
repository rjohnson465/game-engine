var a = 1;
if frame < .5*fadeDuration {
	a = (1/(.5*fadeDuration))*frame;
} else {
	a = ((-1/(.5*fadeDuration))*frame)+2;
}

// the fade rectangle
draw_set_alpha(a);
draw_set_color(c_black);
draw_rectangle(0,0,room_width,room_height,false);
draw_set_alpha(1);