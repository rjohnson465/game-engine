/// draw_text_outline(x, y, text, color1,color2, *outline_color);

var x1 = argument[0],
  y1 = argument[1],
  text = argument[2];
  c1 = argument[3];
  c2 = argument[4];
  outlineColor = c_black;

//var c2 = draw_get_colour();

if (argument_count >= 6)
{
  outlineColor = argument[5];
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
draw_text_color(x1,y1,text,c1,c1,c2,c2,draw_get_alpha());
//draw_text(x1, y1, text);