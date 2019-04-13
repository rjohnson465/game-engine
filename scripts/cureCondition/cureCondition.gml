// cureCondition(condition)
/// @param condition string MAGIC | FIRE | "<custom condi>"
/// cure any and all conditions for a combatant


// cure a specific condition
var condition = argument[0];
ds_map_replace(conditionPercentages,condition,0);
var conditionEmitter = ds_map_find_value(conditionsEmittersMap,condition);
audio_emitter_gain(conditionEmitter,0);
var sndId = ds_map_find_value(conditionSoundsMap, condition);
if (sndId != noone) {
	audio_stop_sound(sndId);
}
