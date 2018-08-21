/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

subType = GemTypes.Topaz;
var condi = condition == NORMAL ? "" : condition+" ";
name = stringCapitalize(condi) + "Topaz";
itemSprite = asset_get_index("spr_gem_topaz_"+condition);