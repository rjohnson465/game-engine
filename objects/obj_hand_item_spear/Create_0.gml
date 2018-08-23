event_inherited();
subType = HandItemTypes.Melee;

name = "Spear";
baseName = "Spear";
spriteName = "spear";
itemSprite = spr_item_spear;
baseValue = 200;

charges = 10;
chargesMax = 10;

range = 250;

ds_map_set(damages,SLASH,[0,0,0,0]);
ds_map_set(damages,PIERCE,[12,15,14,15]);
ds_map_set(damages,CRUSH,[0,0,0,0]);
act = 1;

//requiredMastery = 1;

//numberOfSockets = 3;