// only destroy particles if this is the last aoe with the attackData ref
var isLastAOEPart = true;
with obj_attack_aoe {
	if attackData == other.attackData && id != other.id {
		isLastAOEPart = false;
	}
}
if isLastAOEPart {
	part_type_destroy(particle);
	part_type_destroy(particle2); particle = -1; particle2 = -1;
}
part_emitter_destroy(system,emitter);
part_system_destroy(system); system = -1; emitter = -1;

ds_list_destroy(combatantsHit); combatantsHit = -1;
audio_emitter_free(soundEmitter); soundEmitter = -1;

ds_map_destroy(additionalDamages); additionalDamages = -1;