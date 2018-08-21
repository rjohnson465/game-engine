/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

subType = GemTypes.Lapis;
var condi = condition == NORMAL ? "" : condition + " ";
name = stringCapitalize(condi) + "Lapis";
itemSprite = asset_get_index("spr_gem_lapis_"+condition);
