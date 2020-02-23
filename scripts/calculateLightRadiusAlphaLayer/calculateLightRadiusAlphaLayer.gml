/// calculateLightRadiusAlphaLayer(layerNum)
/// @param layerNum
/// return appropriate alpha value for light radii, based on the lighting of a certain layer (light_main)

var layerNum = argument0;

var map = ds_map_find_value(global._light_layers,layerNum);

if map == undefined return 1;

if variable_instance_exists(id, "owner") && variable_instance_exists(owner, "isLightRadiusAlphaFixed") {
	if owner.isLightRadiusAlphaFixed {
		return owner.lightRadiusAlpha;
	}
}

if variable_instance_exists(id, "isLightRadiusAlphaFixed") {
	if id.isLightRadiusAlphaFixed && variable_instance_exists(id, "owner") {
		return owner.lightRadiusAlpha;
	} else {
		return .1; // ??
	}
}

var lightColor = ds_map_find_value(map,"_light_color"); 

var luma = getLumaForColor(lightColor);

// luma at 256 = light is bright AF, luma at 0 = light DNE
// when x is 0, want 1, when x is 256, want 0
var lightRadiusAlpha = ((-1/128)*luma) + 1 + .35;
if lightRadiusAlpha > 1 lightRadiusAlpha = 1;

var wintryRooms = [rm_winter, rm_xmas_town, rm_tundra, rm_krampus, rm_hanukkah_village, rm_clayfields, rm_golemking];

if	arrayIncludes(wintryRooms, room) && 
	!(object_index == obj_light_radius && owner.object_index == obj_item_drop_persistent) {
	if lightRadiusAlpha > .3 {
		lightRadiusAlpha = .3;
	}
}


return lightRadiusAlpha;