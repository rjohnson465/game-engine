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
#macro FINE "fine"
#macro EXQUISITE "exquisite"

global.ALL_GEM_CONDITIONS = [CRACKED,NORMAL,FINE,EXQUISITE];
subType = GemTypes.Hematite;
type = ItemTypes.Other;
condition = global.gemCondition;

isStackable = true;
//isUsable = true;

//description = "Use to revive upon death with no penalty except being Jewish. Can use at any time to restore all health and stamina. Eat my dick I am a lobster.";

