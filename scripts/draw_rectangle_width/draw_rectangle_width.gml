/// draw_rectangle_width(x1, y1, x2, y2, w)

/// @param x1
/// @param y1 
/// @param x2
/// @param y2
/// @param w

var x1, x2, y1, y2, w;
x1 = argument[0];
x2 = argument[2];
y1 = argument[1];
y2 = argument[3];
w = argument[4];
draw_line_width(x1, y1, x2, y1, w);
draw_line_width(x2, y1, x2, y2, w);
draw_line_width(x1, y2, x2, y2, w);
draw_line_width(x1, y1, x1, y2, w);