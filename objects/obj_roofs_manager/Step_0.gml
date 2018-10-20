with obj_player {
	
	var floorNum = getLayerFloorNumber(layer);
	var s = "tiles_roofs_floor_"+string(floorNum);
	var l = layer_get_id(s);
	if !layer_exists(l) continue;
	var tmap = layer_tilemap_get_id(l);
	if tmap >= 0 {
		var tile = tilemap_get_at_pixel(tmap,x,y);
		if tile {
			layer_tile_alpha(tile,.5);
		}
	}
}