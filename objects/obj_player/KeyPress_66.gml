if room == game_menu {
	exit;
}//alert("Shields can only be equipped in the left hand",c_yellow,60);

//xpTemp += 1000;

//questStart(obj_quest_unfairyslayer);

//var propChance = [[ModifiableProperties.OffHandDamage,10000]];
var typeMap = ds_map_create();
ds_map_add(typeMap,ItemTypes.HandItem,1);
ds_map_add(typeMap,ItemTypes.Other,0);
ds_map_add(typeMap,ItemTypes.Head,0);
ds_map_add(typeMap,ItemTypes.Ring,0);
var rarityMap = ds_map_create();
ds_map_add(rarityMap,ItemRarities.Normal,1);
ds_map_add(rarityMap,ItemRarities.Fine,1);
ds_map_add(rarityMap,ItemRarities.Masterwork,1);
ds_map_add(rarityMap,ItemRarities.Legendary,1);
addItemToInventory(maybeMakeItem(100,rarityMap,typeMap,noone,noone,noone));

ds_map_destroy(typeMap);
//addItemToInventory(makeGold(1000000,2000000));

/*
var m = ds_map_create();
ds_map_replace(m,ModifiableProperties.HpMax,25);
ds_map_replace(m,ModifiableProperties.HpRegen,50);
ds_map_replace(m,ModifiableProperties.OffHandDamage,100);
var newM = getNormalizedWeightMap(m);

var newNewM = getCumulativeProbabilitiesMap(newM);

var a = 2;