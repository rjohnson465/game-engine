global.snd = snd_amb_bar_noise;
global.sndFalloffRef = 100;
global.sndFalloffMax = AUDIO_MAX_FALLOFF_DIST;
global.sndFalloffFactor = 1;
global.sndGain = 1;
global.sndIsLooping = true;
// Inherit the parent event
event_inherited();

