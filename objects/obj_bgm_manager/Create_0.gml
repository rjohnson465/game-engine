bgmEmitter = audio_emitter_create();
bgmEmitterGain = .5;

bgmCurrentIndex = noone;
bgmPossibilities = noone;
bgmCurrent = noone;
bgmAlarmSet = false;

bossExists = false; // tells if we're in a boss room, which has special music rules