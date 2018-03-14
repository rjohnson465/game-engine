//if keyboard_check(ord("Q")) and var_greyscale_fade<1 var_greyscale_fade+=0.005;
//if keyboard_check(ord("A")) and var_greyscale_fade>0 var_greyscale_fade-=0.005;

if var_greyscale_fade < 1 var_greyscale_fade+= .1;

if var_greyscale_fade == 1 {
	if textFadeFrame < textFadeTotalFrames {
		textFadeFrame++;
	}
} else acceptingInput = true;

var p = global.player;
var fade = noone;
with obj_fade {
	if owner == other.id {
		fade = id;
	}
}

var UP = keyboard_check_released(vk_up);
if gamepad_is_connected(p.gamePadIndex) {
	UP = keyboard_check_released(vk_up) || gamepad_button_check_released(p.gamePadIndex,gp_padu);
}

var DOWN = keyboard_check_released(vk_down);
if gamepad_is_connected(p.gamePadIndex) {
	DOWN = keyboard_check_released(vk_down) || gamepad_button_check_released(p.gamePadIndex,gp_padd);
}

if UP || DOWN && fade == noone && acceptingInput {
	selectedOption = selectedOption == ReviveOptions.Fountain ? ReviveOptions.Orb : ReviveOptions.Fountain;
}

var ENTER = keyboard_check_released(vk_enter);
if gamepad_is_connected(p.gamePadIndex) {
	ENTER = keyboard_check_released(vk_enter) || gamepad_button_check_released(p.gamePadIndex,gp_face1);
}

if ENTER && acceptingInput {
	
	global.fadeDuration = 30;
	global.owner = id;
	instance_create_depth(x,y,-100000,obj_fade);
}

if fade != noone && selectedOption == ReviveOptions.Fountain {
	if fade.frame == .5*fade.fadeDuration {
		with p {
			hp = maxHp;
			isDying = false;
			isAlive = true;
			visible = true;
			alpha = 1;
			room_speed = 30;
			view_set_surface_id(0,application_surface);
		
			if lastFountainRoom == noone {
				var nearestFountain = instance_nearest(x,y,obj_fountain);
				lastFountain = nearestFountain;
				lastFountainRoom = nearestFountain.nativeRoom;
				lastFountainX = nearestFountain.spawnX;
				lastFountainY = nearestFountain.spawnY;
				lastFountainZ = nearestFountain.layerName;
			}
			room = lastFountainRoom;
			x = lastFountainX;
			y = lastFountainY;
			//layer = lastFountainZ;
			//layerToMoveTo = layer_get_name(lastFountainZ);
			layerToMoveTo = lastFountainZ;
			justRevivedAtFountain = true;

		}
		
		instance_destroy(id,true);
	} 
}