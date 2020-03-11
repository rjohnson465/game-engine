/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	
	// cannot use coin during event
	with obj_event_parent {
		if isActive && !isFinished {
			alert("Cannot use Ancient Coin during events!", c_red);
			other.isInUse = false;
			other.isFadeMade = false;
			other.fade = noone;
			other.isUseCycleInProgress = false;
			exit;
		}
	}
	
	if !isFadeMade && fade == noone {
		global.fadeDuration = 30;
		global.owner = id;
		fade = instance_create_depth(x, y, 1, obj_fade);
		isFadeMade = true;
	}
	else if isFadeMade && !instance_exists(fade) {
		isInUse = false;
		isFadeMade = false;
		fade = noone;
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