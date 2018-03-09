/// drawCombatText(text,combatant,*duration)

/// @param text
/// @param combatant
/// @param *duration

var text = argument[0];
var combatant = argument[1];
var duration = 60;
if argument_count == 3 {
	duration = argument[2];
}

global.combatText = text;
global.combatant = combatant;
global.textDuration = duration;
instance_create_layer(x,y,layer,obj_combat_text);