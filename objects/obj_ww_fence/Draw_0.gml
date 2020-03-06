var gridWidth = sprite_width div 32;
var remainder = sprite_width % 32;
var totalWidth = sprite_width;
var drawnWidth = 0;

// no matter what, we must draw the start sprite first
var xx = x; var yy = y;
draw_sprite_ext(startSprite, 0, xx, yy, 1, 1, image_angle, c_white, 1);
xx = xx + lengthdir_x(32, image_angle);
yy = yy + lengthdir_y(32, image_angle);
drawnWidth += 32;

gridWidth -= 1; // account for start sprite

if isActive {
	index = (index + (sprite_get_speed(midSprite)/room_speed)) mod sprite_get_number(midSprite);
}

// draw one tile of conveyer belt for each cell
// account for the angle this belt is at

for (var i = 0; i < gridWidth - 1; i++) {
	
	draw_sprite_ext(midSprite, index, xx, yy, 1, 1, image_angle, image_blend, 1);
	
	// get new xx and yy values 
	xx = xx + lengthdir_x(32, image_angle);
	yy = yy + lengthdir_y(32, image_angle);
	
	drawnWidth += 32;
}

// if there is some remainder between 32 and 64, draw part of a mid sprite before drawing the end
// increment xx and yy only partially (remainder amount)
if (totalWidth - drawnWidth) - 32 > 0 {
	var w = (totalWidth - drawnWidth) - 32; 
	var sh = sprite_get_height(midSprite);
	draw_sprite_general(midSprite, index, 0, 0, w, sh, xx, yy, 1, 1, image_angle, image_blend, image_blend, image_blend, image_blend, 1);
	xx = xx + lengthdir_x(w, image_angle);
	yy = yy + lengthdir_y(w, image_angle);
}

// draw end sprite
draw_sprite_ext(endSprite, 0, xx, yy, 1, 1, image_angle, image_blend, 1);
