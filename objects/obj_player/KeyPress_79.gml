//alert("Shields can only be equipped in the left hand",c_yellow,60);

//xpTemp += 1000;

var propChance = [[ModifiableProperties.OffHandDamage,10000]];
addItemToInventory(maybeMakeItem(100,noone,noone,noone,noone,propChance));

//addItemToInventory(makeGold(1000000,2000000));

/*
var m = ds_map_create();
ds_map_replace(m,ModifiableProperties.HpMax,25);
ds_map_replace(m,ModifiableProperties.HpRegen,50);
ds_map_replace(m,ModifiableProperties.OffHandDamage,100);
var newM = getNormalizedWeightMap(m);

var newNewM = getCumulativeProbabilitiesMap(newM);

var a = 2;