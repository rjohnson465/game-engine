/// draw_text_outline(x, y, text, color1,color2,*xscale,*yscale,*angle,*outline_color);
/// @param x
/// @param y
/// @param text
/// @param color1
/// @param color2
/// @param *xscale
/// @param *yscale
/// @param *angle
/// @param *outline_color

var x1 = argument[0],
  y1 = argument[1],
  text = argument[2];
  c1 = argument[3];
  c2 = argument[4];
  outlineColor = c_black;
  xs = 1;
  ys = 1;
  a = 0;

//var c2 = draw_get_colour();

if (argument_count == 9)
{
  outlineColor = argument[9];
}
else if argument_count == 8 {
	xs = argument[5];
	ys = argument[6];
	a = argument[7];
}

draw_set_color(outlineColor);

draw_text(x1 - 1, y1 - 1, text);
draw_text(x1, y1 - 1, text);
draw_text(x1 + 1, y1 - 1, text);
draw_text(x1 - 1, y1, text);
draw_text(x1 + 1, y1, text);
draw_text(x1 - 1, y1 + 1, text);
draw_text(x1, y1 + 1, text);
draw_text(x1 + 1, y1 + 1, text);

//draw_set_color(c2);
draw_text_transformed_color(x1,y1,text,xs,ys,a,c1,c1,c2,c2,draw_get_alpha());
//draw_text_color(x1,y1,text,c1,c1,c2,c2,draw_get_alpha());
//draw_text(x1, y1, text);