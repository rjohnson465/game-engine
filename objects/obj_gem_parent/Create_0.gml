/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

enum GemTypes {
	Ruby,
	Emerald,
	Aquamarine,
	Lapis,
	Topaz,
	Hematite	
}

#macro CRACKED "cracked"
#macro NORMAL ""
#macro EXQUISITE "exquisite"
#macro FLAWLESS "flawless"

global.ALL_GEM_CONDITIONS = [CRACKED,NORMAL,EXQUISITE,FLAWLESS];
subType = GemTypes.Hematite;
type = ItemTypes.Other;
condition = global.gemCondition;
isStackable = true;

soundDrop = snd_item_gem;