/// goBackFromNamePrice()
audio_play_sound(snd_ui_click1,1,0);
if global.fountainGui.currentMenu == INSERTGEM {
	global.fountainGui.currentSubMenu = CHOOSEGEM;
} else if global.fountainGui.currentMenu == BREAKDOWNITEM {
	global.fountainGui.currentSubMenu = CHOOSEITEM;
}