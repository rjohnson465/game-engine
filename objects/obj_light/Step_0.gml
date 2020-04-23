
direction = 0;
speed = 0;
floatingFrame += 1;
if floatingFrame > 60 {
	floatingFrame = 0;
}
var scale = .1*cos((pi*floatingFrame)/30)+.9; // normal floating
light_set_scale(scale);


