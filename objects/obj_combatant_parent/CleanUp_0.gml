var ck = ds_map_find_first(conditionsEmittersMap);
for (var i = 0; i < ds_map_size(conditionsEmittersMap); i++) {
	var emitter = ds_map_find_value(conditionsEmittersMap,ck);
	audio_emitter_free(emitter); emitter = -1;
	ck = ds_map_find_next(conditionsEmittersMap,ck);
}
ds_map_destroy(conditionsEmittersMap); conditionsEmittersMap = -1;

