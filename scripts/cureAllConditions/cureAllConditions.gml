// cureAllConditions()
/// cure any and all conditions for a combatant


// cure any and all conditions
var currentCondition = ds_map_find_first(conditionPercentages);
for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
	ds_map_replace(conditionPercentages,currentCondition,0);
	var conditionEmitter = ds_map_find_value(conditionsEmittersMap,currentCondition);
	audio_emitter_gain(conditionEmitter,0);
	currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
}