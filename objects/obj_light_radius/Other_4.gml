if !instance_exists(owner) {
	light_destroy_layer(getLayerFloorNumber(layer), id);
	instance_destroy(id,1);
	exit;
}

colorAlpha = calculateLightRadiusAlphaLayer(floorNum);
light_set_alpha(colorAlpha);

if (owner.object_index == obj_item_drop || owner.object_index == obj_portal) && colorAlpha < .5 {
	colorAlpha = .5;
}

if !persistent || (persistent && owner.object_index == obj_item_drop) {
	light_create_layer(spr, scale, color, colorAlpha, 0, true);
	if owner == global.player {
		persistent = true;
	}
}