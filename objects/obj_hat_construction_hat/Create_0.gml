/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Construction Hat";
baseName = "Construction Hat";
spriteName = "construction_hat";
itemSprite = spr_item_construction_hat;

soundDrop = snd_item_wood;

description = "A construction hat from the Fairy Lamplight Factory. Before the robots were made, fairies had to do the dangerous work of making lamplights. As such, they wore hats that could withstand crushing debris and electricity."

isSpecialHat = true;

specialHatDefenses = ds_map_create();
ds_map_replace(specialHatDefenses, 1, [[SLASH, 10],[CRUSH, 17],[PIERCE, 5], [LIGHTNING, 50]]);
ds_map_replace(specialHatDefenses, 2, [[SLASH, 18],[CRUSH, 26],[PIERCE, 9], [LIGHTNING, 50]]);

specialHatProperties = ds_map_create();

weight = 10;
poise = 3;