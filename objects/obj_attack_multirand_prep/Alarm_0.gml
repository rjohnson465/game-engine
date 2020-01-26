global.attackData = attackData;
global.owner = owner;

instance_create_depth(x,y,depth,obj_attack_multirand);
if prepSoundIndex >= 0 {
	audio_stop_sound(prepSoundIndex);
}

instance_destroy(id, 1);