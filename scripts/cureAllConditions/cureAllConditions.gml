// cureAllConditions()
/// cure any and all conditions for a combatant


// cure any and all conditions
var currentCondition = ds_map_find_first(conditionPercentages);
for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
	ds_map_replace(conditionPercentages,currentCondition,0);
	var conditionEmitter = ds_map_find_value(conditionsEmittersMap,currentCondition);
	if conditionEmitter != undefined {
		audio_emitter_gain(conditionEmitter,0);
		var sndId = ds_map_find_value(conditionSoundsMap, currentCondition);
		if (sndId != noone) {
			audio_stop_sound(sndId);
		}
	}
	currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
}