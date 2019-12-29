// display alert at nearest loc to center top screen
depth = global.ui.depth+1;
item = global.item;

// message = global.alertMessage;
// color = global.alertMessageColor;
alertNumber = instance_number(obj_alert);
// draw_set_font(font_main);
alertHeight = sprite_get_height(spr_slot_head);

frame = 0;
totalFrames = global.alertMessageLength;
isVisible = true;

/*
// restrict total messages diaplyed to no more than 3 at a time
if instance_number(object_index) > 3 {
	// find the oldest alert and destroy it
	var smallestNum = 1000; var alertToDestroy = noone;
	with obj_alert {
		if alertNumber < smallestNum && isVisible {
			smallestNum = alertNumber;
			alertToDestroy = id;
		}
	}
	alertToDestroy.isVisible = false;
}
// do not display the exact same message twice on screen
var isAlreadyOnScreen = false;
with obj_alert {
	if id != other && message == other.message {
		isVisible = false;
		isAlreadyOnScreen = true;
	}
}

if isVisible && color == c_red {
	audio_play_sound(snd_ui_error,1,0);
}