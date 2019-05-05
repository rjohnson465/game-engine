var rmap = ds_map_create();
	ds_map_replace(rmap,ItemRarities.Normal,0);
	ds_map_replace(rmap,ItemRarities.Fine,9);
	ds_map_replace(rmap,ItemRarities.Masterwork,9);
	ds_map_replace(rmap,ItemRarities.Legendary,0);
	var tmap = ds_map_create();
	ds_map_replace(tmap,ItemTypes.Ring,0);
	ds_map_replace(tmap,ItemTypes.HandItem,1);
	ds_map_replace(tmap,ItemTypes.Head,0);
	ds_map_replace(tmap,ItemTypes.Other,0);
	var item1 = maybeMakeItem(100,rmap,tmap); //randomly generated item

addItemToInventory(item1);
	
ds_map_destroy(rmap); rmap = -1;
ds_map_destroy(tmap); tmap = -1;