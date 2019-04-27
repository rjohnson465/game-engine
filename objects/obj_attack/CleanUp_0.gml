if part_system_exists(system) && part_emitter_exists(system, emitter) {
	part_emitter_destroy(system,emitter);
}
if part_system_exists(system) {
	part_system_destroy(system); system = -1; emitter = -1;
}

if ds_exists(combatantsHit, ds_type_list) {
	ds_list_destroy(combatantsHit); combatantsHit = -1;
}

if audio_emitter_exists(soundEmitter) {
	audio_emitter_gain(soundEmitter, 0);
	audio_emitter_free(soundEmitter); soundEmitter = -1;
}


if part_type_exists(particle) {
	part_type_destroy(particle);
}

if part_type_exists(particle2) {
	part_type_destroy(particle2);
}
/*
if array_length_1d(weaponParticles) > 0 {
	for (var i = 0; i < array_length_1d(weaponParticles); i++) {
		var p = weaponParticles[i];
		if part_type_exists(p) {
			part_type_destroy(p);
		}
	}
}*/

if isRanged && instance_exists(weapon) && weapon != noone && weapon.isTwoHanded && owner == global.player {
	event_perform(ev_alarm,1);
}

if ds_exists(additionalDamages, ds_type_map) {
	ds_map_destroy(additionalDamages); additionalDamages = -1;
}