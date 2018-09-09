/// getLumaForColor(color)
/// @param color

var c = argument0;

var R = color_get_red(c);
var G = color_get_green(c);
var B = color_get_blue(c);

var luma = (0.2126*R + 0.7152*G + 0.0722*B);
return luma;