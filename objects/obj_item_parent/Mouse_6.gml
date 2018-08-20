if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY || global.inventory.isConfirmingDestroyItem exit;

global.inventory.isConfirmingDestroyItem = true;
audio_play_sound(snd_ui_tab1,1,0);