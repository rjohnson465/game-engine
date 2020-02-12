/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	
	if !isFadeMade && fade == noone {
		global.fadeDuration = 30;
		global.owner = id;
		fade = instance_create_depth(x, y, 1, obj_fade);
		isFadeMade = true;
	}
	else if isFadeMade && !instance_exists(fade) {
		isInUse = false;
	}
	else {
		if fade.frame == .5*fade.fadeDuration {
			with global.player {
				global.ui.isShowingMenus = false;
				returnToLastFountain();
				other.fade.frame++;
			}
		}
	}
}