/// scr_quest_sth_togazebo

audio_play_sound(snd_magic_magic_hit, 1, 0);
audio_play_sound(snd_magic_ice_hit, 1, 0);
audio_play_sound(snd_shield_hit_metal, 1, 0);

var q = instance_nearest(x, y, obj_quest_savingtheholidays);
var system = q.system;
var emitter = q.emitter;
var part = q.part;

var santa = instance_nearest(x, y, obj_npc_santa);
var david = instance_nearest(x, y, obj_npc_david);

part_emitter_region(system, emitter, santa.x, santa.x+1, santa.y, santa.y + 1, ps_shape_rectangle, ps_distr_gaussian);
part_emitter_burst(system, emitter, part, 7);

part_emitter_region(system, emitter, david.x, david.x+1, david.y, david.y + 1, ps_shape_rectangle, ps_distr_gaussian);
part_emitter_burst(system, emitter, part, 7);
