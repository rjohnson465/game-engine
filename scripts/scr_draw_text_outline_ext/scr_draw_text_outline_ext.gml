/// draw_text_outline(x, y, text, color1,color2,*xscale,*yscale,*angle,*outline_color,*sep,*w);
/// @param x
/// @param y
/// @param text
/// @param color1
/// @param color2
/// @param *xscale
/// @param *yscale
/// @param *angle
/// @param *outline_color
/// @param *sep
/// @param w

var x1 = argument[0],
  y1 = argument[1],
  text = argument[2],
  c1 = argument[3],
  c2 = argument[4];
  var outlineColor = c_black
  var xs = 1;
  var ys = 1;
  var a = 0;
  var sep = noone;
  var w = noone;

//var c2 = draw_get_colour();

if argument_count == 11 {
	xs = argument[5];
	ys = argument[6];
	a = argument[7];
	outlineColor = argument[8];
	sep = argument[9];
	w = argument[10];
}

if (argument_count == 9)
{
	xs = argument[5];
	ys = argument[6];
	a = argument[7];
	outlineColor = argument[8];
}
else if argument_count == 8 {
	xs = argument[5];
	ys = argument[6];
	a = argument[7];
}

if argument_count == 11 {
	draw_set_color(outlineColor);
	draw_text_ext_transformed(x1 - 1, y1 - 1,text,sep,w,xs,ys,a);
	draw_text_ext_transformed(x1, y1 - 1, text,sep,w,xs,ys,a);
	draw_text_ext_transformed(x1 + 1, y1 - 1,sep,w,text,xs,ys,a);
	draw_text_ext_transformed(x1 - 1, y1,text,sep,w,xs,ys,a);
	draw_text_ext_transformed(x1 + 1, y1,text,sep,w,xs,ys,a);
	draw_text_ext_transformed(x1 - 1, y1 + 1,sep,w,text,xs,ys,a);
	draw_text_ext_transformed(x1, y1 + 1,text,sep,w,xs,ys,a);
	draw_text_ext_transformed(x1 + 1, y1 + 1,sep,w,text,xs,ys,a);

	draw_text_ext_transformed_color(x1,y1,text,sep,w,xs,ys,a,c1,c1,c2,c2,draw_get_alpha());
} else {

	draw_set_color(outlineColor);
	draw_text_transformed(x1 - 1, y1 - 1,text,xs,ys,a);
	draw_text_transformed(x1, y1 - 1, text,xs,ys,a);
	draw_text_transformed(x1 + 1, y1 - 1,text,xs,ys,a);
	draw_text_transformed(x1 - 1, y1,text,xs,ys,a);
	draw_text_transformed(x1 + 1, y1,text,xs,ys,a);
	draw_text_transformed(x1 - 1, y1 + 1,text,xs,ys,a);
	draw_text_transformed(x1, y1 + 1,text,xs,ys,a);
	draw_text_transformed(x1 + 1, y1 + 1,text,xs,ys,a);

	draw_text_transformed_color(x1,y1,text,xs,ys,a,c1,c1,c2,c2,draw_get_alpha());
}
//draw_text_color(x1,y1,text,c1,c1,c2,c2,draw_get_alpha());
//draw_text(x1, y1, text);