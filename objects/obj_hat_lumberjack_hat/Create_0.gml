/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Lumberjack Hat";
baseName = "Lumberjack Hat";
spriteName = "lumberjack_hat";
itemSprite = spr_item_lumberjack_hat;

ds_map_replace(defenses,SLASH,12);
ds_map_replace(defenses,CRUSH,4);
ds_map_replace(defenses,PIERCE,0);

//numberOfSockets = 1;