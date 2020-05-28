
draw_set_color(c_white);
draw_self();

if layer != global.player.layer exit;

draw_set_color(c_lime);
draw_point(x, y);

var sw = sprite_get_width(sprite_index);
var sh = sprite_get_height(sprite_index);
var w = sw * image_xscale;
var h = sh * image_yscale;
var diagonalLength = sqrt(sqr(w) + sqr(h));
var sinA = h / diagonalLength;
var a = image_angle - radtodeg(arcsin(sinA));


var brx = x + lengthdir_x(diagonalLength, a);
var bry = y + lengthdir_y(diagonalLength, a);

draw_set_color(c_white);
draw_point(brx, bry);

var p1x = x; var p1y = y;
var p2x = x + lengthdir_x(w, image_angle); var p2y = y + lengthdir_y(w, image_angle);
var p3x = x + lengthdir_x(diagonalLength, a); var p3y = y + lengthdir_y(diagonalLength, a);
var p4x = x + lengthdir_x(h, image_angle - 90); var p4y = y + lengthdir_y(h, image_angle - 90);

draw_text(p1x, p1y, "p1");
draw_point(p2x, p2y);
draw_text(p2x, p2y, "p2");
draw_text(p3x, p3y, "p3");
draw_point(p4x, p4y);
draw_text(p4x, p4y, "p4");

