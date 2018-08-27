event_inherited();
subType = HandItemTypes.Melee;

name = "Wand";
baseName = "Wand";
spriteName = "wand";
itemSprite = spr_item_wand;
baseValue = 200;

// for each attack in chain
numberOfTargets = [2];

charges = 50;
chargesMax = 50;

durability = 10;
durabilityMax = 10;

range = 15;

ds_map_set(damages,SLASH,[0,0]);
ds_map_set(damages,PIERCE,[0,0]);
ds_map_set(damages,CRUSH,[1,5]);
staminaCostArray=[5];

act = 1;

//numberOfSockets = 3;
attackSounds = [snd_dagger_attack_1];