/// fs_save_player
/// returns a map of player data

var sd_player = ds_map_create();

with global.player {

	if lastFountain == noone {
		lastFountain = instance_nearest(x,y,obj_fountain);
		lastFountainX = lastFountain.spawnX;
		lastFountainY = lastFountain.spawnY;
		lastFountainZ = lastFountain.layerName;
		lastFountainRoom = room;
	}

	ds_map_replace(sd_player,"LastFountainX",lastFountainX);
	ds_map_replace(sd_player,"LastFountainY",lastFountainY);
	ds_map_replace(sd_player,"LastFountainZ",lastFountainZ); // layer name
	ds_map_replace(sd_player,"LastFountainRoom",lastFountainRoom);

}

return sd_player;