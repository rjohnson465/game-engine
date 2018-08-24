if global.player.hp <= 0 exit;
if global.isWishing exit;
if global.isInteractingWithNpc && !global.isTrading exit;
if scr_is_fading() exit;
audio_play_sound(snd_ui_click1,1,0);
with obj_item_selector {
	if global.ui.isShowingMenus && type == SelectorTypes.Equip {
		performSelectorBackspacePressed();
	}
}

if global.isTrading {
	var vi = obj_vendor_items; //var pli = obj_player_items; var bs = obj_buy_sell;
	with vi {
		owner.isInteractingWithPlayer = false;
		global.isInteractingWithNpc = false;
		owner.showBuySell = false;
		global.isTrading = false;
	}
}

if isShowingMenus && currentMenu == SKILLS {
	isShowingMenus = false;
} else {
	isShowingMenus = true;
	currentMenu = SKILLS;
}