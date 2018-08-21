/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

subType = GemTypes.Aquamarine;
var condi = condition == NORMAL ? "" : condition + " ";
name = stringCapitalize(condi)+"Aquamarine";
itemSprite = asset_get_index("spr_gem_aquamarine_"+condition);