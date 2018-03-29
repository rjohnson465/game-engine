/// calculateLightRadiusAlpha()
/// return appropriate alpha value for light radii, based on the global lighting (light_main)

var lightColor = global._light_color;

var R = color_get_red(lightColor);
var G = color_get_green(lightColor);
var B = color_get_blue(lightColor);

var luma = (0.2126*R + 0.7152*G + 0.0722*B);

// luma at 256 = light is bright AF, luma at 0 = light DNE
// when x is 0, want 1, when x is 256, want 0
var lightRadiusAlpha = ((-1/128)*luma) + 1;

return lightRadiusAlpha;