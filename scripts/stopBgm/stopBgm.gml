/// stopBgm()
/// stop the current background music
/// must be called by bgm manager

// stop old bgm
if bgmCurrentIndex >= 0 {
	audio_stop_sound(bgmCurrentIndex);
	bgmCurrentIndex = -1;
}