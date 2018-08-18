event_inherited();
subType = HandItemTypes.Melee;

name = "Warhammer";
baseName = "Warhammer";
spriteName = "warhammer";
itemSprite = spr_item_warhammer;
baseValue = 200;

charges = 10;
chargesMax = 10;

range = 60;

ds_map_set(damages,SLASH,[0,0,0,0,0,0]);
ds_map_set(damages,PIERCE,[0,0,0,0,0,0]);
ds_map_set(damages,CRUSH,[22,30,25,35,35,45]);
act = 1;

//requiredMastery = 1;

//numberOfSockets = 3;