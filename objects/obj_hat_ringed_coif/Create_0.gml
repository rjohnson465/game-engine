/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Ringed Coif";
baseName = "Ringed Coif";
spriteName = "ringed_coif";
itemSprite = spr_item_ringed_coif;
baseValue = 750;

soundDrop = snd_item_cloth;

ds_map_replace(defenses,SLASH,10);
ds_map_replace(defenses,CRUSH,5);
ds_map_replace(defenses,PIERCE,15);

poise = 8;

description = "A medium-weight hood of ringmail, capable of withstanding piercing attacks well. Also good for those who chronically propose marriage."

weight = 10;

act = 1;