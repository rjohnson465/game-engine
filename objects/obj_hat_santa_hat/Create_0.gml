/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Santa Hat";
baseName = "Santa Hat";
spriteName = "santa_hat";
itemSprite = spr_item_santa_hat;

soundDrop = snd_item_cloth;

description = "One of Santa's many hats, worn each night when he goes out drunk driving his sleigh. Provides excellent ice and magic defense, but paltry physical protection."

isSpecialHat = true;

specialHatDefenses = ds_map_create();
ds_map_replace(specialHatDefenses, 1, [[SLASH, 5],[CRUSH, 5],[PIERCE, 5], [ICE, 50], [MAGIC, 33]]);
ds_map_replace(specialHatDefenses, 2, [[SLASH, 9],[CRUSH, 9],[PIERCE, 9], [ICE, 50], [MAGIC, 33]]);

specialHatProperties = ds_map_create();

weight = 4;
poise = 3;