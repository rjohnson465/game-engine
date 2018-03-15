// if mouse enters a button, highlight it
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

// fountain revive
var mouseOverFountainRevive = mouse_x > vx + reviveAtFountainButtonCoordinates[0] && mouse_y > vy + reviveAtFountainButtonCoordinates[1]
	&& mouse_x < vx +reviveAtFountainButtonCoordinates[2] && mouse_y < vy + reviveAtFountainButtonCoordinates[3];
var a = point_in_rectangle(mouse_x,mouse_y,vx+reviveAtFountainButtonCoordinates[0],
	vy+reviveAtFountainButtonCoordinates[1],vx+reviveAtFountainButtonCoordinates[2],
	vy+reviveAtFountainButtonCoordinates[3]);

if mouse_check_button_released(mb_left) {
	show_debug_message(string(mouse_x)+","+string(mouse_y));
}

//show_debug_message(string(mouse_x) + "," + string(mouse_y));
//show_debug_message(string(vx+reviveAtFountainButtonCoordinates[0]));

if a selectedOption = ReviveOptions.Fountain; 
var mouseOverOrbRevive = acceptingInput && mouse_x > vx + reviveWithOrbButtonCoordinates[0] && mouse_y > vy + reviveWithOrbButtonCoordinates[1]
	&& mouse_x < vx + reviveWithOrbButtonCoordinates[2] && mouse_y < vy + reviveWithOrbButtonCoordinates[3];
if mouseOverOrbRevive selectedOption = ReviveOptions.Orb;


if !surface_exists(surf) {
	surf = surface_create(var_resolution_x, var_resolution_y);
} 

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

if (ENTER || ((mouseOverFountainRevive) && mouse_check_button_released(mb_left))) && acceptingInput {
	
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