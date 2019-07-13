/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Bike Helmet";
baseName = "Bike Helmet";
spriteName = "bike_helmet";
itemSprite = spr_item_bike_helmet;

soundDrop = snd_item_wood;

ds_map_replace(defenses,SLASH,7);
ds_map_replace(defenses,CRUSH,10);
ds_map_replace(defenses,PIERCE,2);

poise = 8;

description = "Do as Mom says, and wear your bike helmet. It absorbs impact with pavement and crushing blows very nicely."

weight = 7;

act = 1;