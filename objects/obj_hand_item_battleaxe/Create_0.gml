event_inherited();
subType = HandItemTypes.Melee;

name = "Battleaxe";
baseName = "Battleaxe";
spriteName = "battleaxe";
itemSprite = spr_item_battleaxe;
baseValue = 200;

range = 60;

ds_map_set(damages,SLASH,[24,25,24,30]);
ds_map_set(damages,PIERCE,[0,0,0,0]);
ds_map_set(damages,CRUSH,[0,0,0,0]);
act = 1;

//requiredMastery = 1;

description = "This two-sided axe requires both hands and incredible strength to use. This was the preferred melee weapon of the Gunfairies, long ago, before their extinction.";

weight = 15;