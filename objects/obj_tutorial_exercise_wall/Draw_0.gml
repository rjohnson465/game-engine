/*

draw_set_color(c_yellow);

var sw = sprite_width; var sh = sprite_height; var a = image_angle;

// bottom mid
var bx = x + lengthdir_x(sh*.5, a + 90);
var by = y + lengthdir_y(sh*.5, a + 90);

// top mid
var tx = x - lengthdir_x(sh*.5, a + 90);
var ty = y - lengthdir_y(sh*.5, a + 90);

// bottom right
var brx = bx + lengthdir_x(sw*.5, a);
var bry = by + lengthdir_y(sw*.5, a);

// bottom left 
var blx = bx - lengthdir_x(sw*.5, a);
var bly = by - lengthdir_y(sw*.5, a);

// top left
var tlx = tx - lengthdir_x(sw*.5, a);
var tly = ty - lengthdir_y(sw*.5, a);

// top right
var trx = tx + lengthdir_x(sw*.5, a);
var try = ty + lengthdir_y(sw*.5, a);


var xx = x + lengthdir_x(sw*.5, a);
var yy = y + lengthdir_y(sw*.5, a);

var xxx = x - lengthdir_x(sw*.5, a);
var yyy = y - lengthdir_y(sw*.5, a);

draw_set_color(c_aqua);
draw_line(xx, yy, xxx, yyy);




/// (xxx, yyy)

/*
draw_line(x, y, xx, yy);
draw_line(x, y, xxx, yyy);
