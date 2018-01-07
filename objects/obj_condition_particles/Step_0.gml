var conditionLevel = ds_map_find_value(owner.conditionLevels,condition);
if conditionLevel == 0 {
	instance_destroy(id,false);
	part_emitter_destroy(system,emitter);
} else {
	part_emitter_region(system,emitter,owner.x,owner.x,owner.y,owner.y,0,0);
	part_emitter_burst(system,emitter,particle, -500);

}
