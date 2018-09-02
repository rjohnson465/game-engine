if room == game_menu {
	exit;
}
xpTemp += 1000;
var typeMap = ds_map_create();
ds_map_add(typeMap,ItemTypes.HandItem,1);
ds_map_add(typeMap,ItemTypes.Other,0);
ds_map_add(typeMap,ItemTypes.Head,0);
ds_map_add(typeMap,ItemTypes.Ring,0);
var rarityMap = ds_map_create();
ds_map_add(rarityMap,ItemRarities.Normal,0);
ds_map_add(rarityMap,ItemRarities.Fine,1);
ds_map_add(rarityMap,ItemRarities.Masterwork,1);
ds_map_add(rarityMap,ItemRarities.Legendary,1);
addItemToInventory(maybeMakeItem(100,rarityMap,typeMap,noone,noone,noone));

ds_map_destroy(typeMap); typeMap = -1;
