event_inherited();
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

// do not destroy particles if they come from attack data (enemy attack)
// these particles will instead be destroyed when the attack data object is destroyed (usually at room end)
if (attackData == noone) {
	if part_type_exists(particle) {
		part_type_destroy(particle);
	}

	if part_type_exists(particle2) {
		part_type_destroy(particle2);
	}
}

if isRanged && instance_exists(weapon) && weapon != noone && weapon.isTwoHanded && owner == global.player {
	event_perform(ev_alarm,1);
}

if ds_exists(additionalDamages, ds_type_map) {
	ds_map_destroy(additionalDamages); additionalDamages = -1;
}

// check if this is the last AOE object of an attack to still be here
// if so, remove this AOE object from player's beenHit list
if owner.type == CombatantTypes.Player exit;
var isLastAOE = true;
with obj_attack_aoe {
	if owner == other.owner && id != other.id {
		isLastAOE = false;
	}
}
if isLastAOE {
	with obj_player {
		var indexToRemove = noone;
		if ds_exists(beenHitWith, ds_type_list) {
			for (var i = 0; i < ds_list_size(beenHitWith); i++) {
				var atkThatHit = ds_list_find_value(beenHitWith, i);
				if is_string(atkThatHit) && string_pos(other.owner.key, atkThatHit) >= 0 {
					indexToRemove = i;
				}
			}
		}
		if indexToRemove >= 0 {
			ds_list_delete(beenHitWith, indexToRemove);
		}
	}
}
	