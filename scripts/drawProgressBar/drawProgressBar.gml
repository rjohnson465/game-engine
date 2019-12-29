/// drawProgressBar(x, y, w, h, percent, c1, c2)
/// @param x
/// @param y
/// @param w
/// @param h
/// @param percent
/// @param c1
/// @param c2

var xx, yy, w, h, percent, c1, c2;
xx = argument[0];
yy = argument[1];
w = argument[2];
h = argument[3];
percent = argument[4];
c1 = argument[5];
c2 = c1;
if argument_count > 6 {
	c2 = argument[6];
}

draw_set_alpha(1);
// bar fill
draw_healthbar(xx, yy, xx + w, yy + h, percent, noone, c1, c2, 0, false, false);
// bar outline
draw_set_color(c_white);
draw_rectangle(xx, yy, xx + w, yy + h, true);
