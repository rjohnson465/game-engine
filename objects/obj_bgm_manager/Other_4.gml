// stop current bgm (maybe, maybe we should fade it out?) and start new bgm music
/*audio_stop_sound(bgmCurrent);
audio_emitter_free(bgmEmitter); bgmEmitter = -1;
bgmCurrent = noone;
bgmEmitter = audio_emitter_create();*/
alarm[2] = -1;
startBgm(); 