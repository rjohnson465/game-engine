if room == game_menu {
	exit;
}

var tmap = ds_map_create();
ds_map_replace(tmap,ItemTypes.Ring,1);
ds_map_replace(tmap,ItemTypes.HandItem,0);
ds_map_replace(tmap,ItemTypes.Head,0);
ds_map_replace(tmap,ItemTypes.Other,0);
var rmap = ds_map_create();
ds_map_replace(rmap,ItemRarities.Normal,2);
ds_map_replace(rmap,ItemRarities.Fine,3);
ds_map_replace(rmap,ItemRarities.Masterwork,3);
ds_map_replace(rmap,ItemRarities.Legendary,1);
var ring = maybeMakeItem(100, rmap, tmap, 1);

addItemToInventory(ring);

ds_map_destroy(rmap); rmap = -1;
ds_map_destroy(tmap); tmap = -1;

/*
xpTemp += 100;
isFlinching = true;
totalFlinchFrames = 40; 
flinchDirection = 360;

/*state = CombatantStates.Staggering;
staggerDuration = 20;
staggerDirection = 360;

/*
xpTemp += 100000;
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
