/// calculateLightRadiusAlphaLayer(layerNum)
/// return appropriate alpha value for light radii, based on the lighting of a certain layer (light_main)

var layerNum = argument0

var map = ds_map_find_value(global._light_layers,layerNum);

var lightColor = ds_map_find_value(map,"_light_color");

var luma = getLumaForColor(lightColor);

// luma at 256 = light is bright AF, luma at 0 = light DNE
// when x is 0, want 1, when x is 256, want 0
var lightRadiusAlpha = ((-1/128)*luma) + 1 + .35;
if lightRadiusAlpha > 1 lightRadiusAlpha = 1;
if lightRadiusAlpha < .5 lightRadiusAlpha = .5;
return lightRadiusAlpha;