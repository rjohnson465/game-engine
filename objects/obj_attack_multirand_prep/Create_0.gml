attackData = global.attackData;
owner = global.owner;
visible = true;
var s = attackData.spriteName+"_"+string(attackData.spriteAttackNumber)+"_"+string(attackData.spriteAttackNumberInChain)+"_projectile";
sprite_index = asset_get_index(s);

alarm[0] = attackData.mrPrepDuration;

prepSoundIndex = noone;
if variable_instance_exists(attackData, "mrPrepSound") {
	prepSoundIndex = audio_play_sound_at(attackData.mrPrepSound, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
}