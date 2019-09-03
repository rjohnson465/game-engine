/// maybeStartNewGame()

// TODO -- check that this will not override a pre-existing file
if doesSaveFileExist(newGameName) {
	isConfirmingDestroySaveFile = true;
	alarm[1] = 2;
} else {
					
	global.fadeDuration = 60;
	global.owner = id;
	fade = instance_create_depth(x,y,-100000,obj_fade);
	audio_play_sound(snd_shield_hit_metal,1,0);
}