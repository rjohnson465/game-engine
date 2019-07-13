bgmEmitter = audio_emitter_create();
bgmEmitterGain = .5;

bgmCurrentIndex = noone;
bgmPossibilities = noone;
bgmCurrent = noone;
bgmAlarmSet = false;

bossExists = false; // tells if we're in a boss room, which has special music rules

// how often to start a new track after an old one has ended, in seconds
//BGM_START_MIN = 15;
//BGM_START_MAX = 30;

BGM_START_MIN = 20;
BGM_START_MAX = 45;

// played tracks
playedTracks = ds_list_create();