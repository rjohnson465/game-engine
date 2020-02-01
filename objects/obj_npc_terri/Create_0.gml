/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Terri the Toaster";
spriteString = "npc_terri";

greeting = [snd_npc_terri_greeting_1, snd_npc_terri_greeting_2];

items = ds_list_create();
var toast = instance_create_depth(x,y,1,obj_item_toast);
toast.count = 2;
toast.value = 500;
ds_list_add(items,toast);

defaultVendorFilter = InventoryFilters.Other;

wanders = false;
isFairy = false;
isFloating = false;

faceSprite = spr_face_terri;