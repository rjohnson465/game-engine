/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Mrs. Claus";
spriteString = "npc_mrsclaus";

greeting = [snd_npc_mrsclaus_greeting_1, snd_npc_mrsclaus_greeting_2, snd_npc_mrsclaus_greeting_3 ];

faceSprite = spr_face_mrsclaus; 

items = ds_list_create();
var ms = instance_create_depth(x,y,1,obj_item_moonshine);
ms.count = 3;
var b = instance_create_depth(x,y,1,obj_item_beer);
b.count = 3;
var w = instance_create_depth(x,y,1,obj_item_wine);
w.count = 3;
ds_list_add(items, ms, b, w);

defaultVendorFilter = InventoryFilters.Other;