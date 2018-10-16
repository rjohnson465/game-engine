colorAlpha = calculateLightRadiusAlphaLayer(floorNum);

if (owner.object_index == obj_item_drop || owner.object_index == obj_portal) && colorAlpha < .5 {
	colorAlpha = .5;
}


light_create_layer(spr, scale, color, colorAlpha, 0, true);