/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Leather Cap";
baseName = "Leather Cap";
spriteName = "leathercap";
itemSprite = spr_item_leathercap;

ds_map_replace(defenses,SLASH,10);
ds_map_replace(defenses,CRUSH,2);
ds_map_replace(defenses,PIERCE,7);

numberOfSockets = 1;