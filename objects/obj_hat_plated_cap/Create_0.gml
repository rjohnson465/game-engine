/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Plated Cap";
baseName = "Plated Cap";
spriteName = "plated_cap";
itemSprite = spr_item_plated_cap;

soundDrop = snd_item_metal;

ds_map_replace(defenses,SLASH,15);
ds_map_replace(defenses,CRUSH,5);
ds_map_replace(defenses,PIERCE,20);
ds_map_replace(defenses,LIGHTNING,-50);

poise = 15;

description = "A cap plated in metal, this hat offers excellent defense against slashing and piercing attacks, but is very heavy. Pretty good way to a get a neck workout."

weight = 15;

act = 1;