/// drawTextWidth(x,y,s,w)
/// @param x
/// @param y
/// @param s
/// @param w
/// force text to fit in a designated width

var xx = argument[0];
var yy = argument[1];
var s = argument[2];
var w = argument[3];

var scale = 1;
var stringWidth = string_width(s);
if stringWidth > w {
	scale = w / stringWidth;
}
draw_text_transformed(xx,yy,s,scale,scale,0);
