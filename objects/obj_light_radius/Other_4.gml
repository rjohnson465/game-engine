colorAlpha = calculateLightRadiusAlpha();

if owner.object_index == obj_item_drop {
	var a = 3;
	var b = owner.x;
	var c = owner.y;
	var d = 3;
}

//if global._lights {
if ds_exists(global._lights,ds_type_list) {
	light_create(spr, scale, color, colorAlpha, 0, true);
}