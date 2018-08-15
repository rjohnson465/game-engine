event_inherited();
subType = HandItemTypes.Melee;

name = "Battleaxe";
baseName = "Battleaxe";
spriteName = "battleaxe";
itemSprite = spr_item_battleaxe;
baseValue = 200;

charges = 10;
chargesMax = 10;

range = 60;

ds_map_set(damages,SLASH,[20,25,22,30]);
ds_map_set(damages,PIERCE,[0,0,0,0]);
ds_map_set(damages,CRUSH,[0,0,0,0]);
act = 1;

//requiredMastery = 1;

//numberOfSockets = 3;