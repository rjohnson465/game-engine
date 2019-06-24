event_inherited();
subType = HandItemTypes.Melee;

name = "Torch";
baseName = "Torch";
spriteName = "torch";
itemSprite = spr_item_torch;
baseValue = 200;

// for each attack in chain
numberOfTargets = [2];

//charges = 50;
//chargesMax = 50;

durability = 10;
durabilityMax = 10;

range = 15;

ds_map_set(damages,SLASH,[0,0]);
ds_map_set(damages,PIERCE,[0,0]);
ds_map_set(damages,CRUSH,[1,3]);
ds_map_set(damages,FIRE,[1,5]);
staminaCostArray=[15];

act = 1;

attackSounds = [snd_axe2h_attack_1];

weight = 2.5;