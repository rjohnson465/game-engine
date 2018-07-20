event_inherited();
subType = HandItemTypes.Melee;

name = "Battleaxe";
baseName = "Battleaxe";
spriteName = "battleaxe";
itemSprite = spr_item_battleaxe;

charges = 10;
chargesMax = 10;

range = 60;

weight = 10;
staggerDuration = 45; // frames
ds_map_set(damages,SLASH,[20,25,22,30]);


act = 1;

requiredMastery = 1;

//numberOfSockets = 3;