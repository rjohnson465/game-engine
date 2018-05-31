/// fs_save_enemies
/// returns a map of all the enemy data in the game
var sd_enemies = ds_map_create();
with obj_enemy_data {
	var sd_enemy = ds_map_create();
	
	ds_map_replace(sd_enemy,"hp",hp);
	ds_map_replace(sd_enemy,"maxHp",maxHp);
	ds_map_replace(sd_enemy,"postX",postX);
	ds_map_replace(sd_enemy,"postY",postY);
	ds_map_replace(sd_enemy,"postZ",postZ);
	ds_map_replace(sd_enemy,"tempPostX",tempPostX);
	ds_map_replace(sd_enemy,"tempPostY",tempPostY);
	ds_map_replace(sd_enemy,"currentX",currentX);
	ds_map_replace(sd_enemy,"currentY",currentY);
	ds_map_replace(sd_enemy,"currentZ",currentZ);
	
	var key = fs_generate_key(enemy);

	ds_map_add_map(sd_enemies,key,sd_enemy);
}

return sd_enemies;