/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Tony, the Unfairy Godfather";
spriteString = "npc_tony";

greeting = noone;

wanders = false;
isFairy = false;
isFloating = false;

faceSprite = spr_face_tony;

path = path_add();


// if appearing in lighteater room, do specific conversation
if room == rm_boss_lighteater {
	isInteractable = false;
	isInteractingWithPlayer = true;
	var c = scr_conv_tony_intro();
	startConversation(c);
	
	
	mp_potential_path(path, global.player.x, global.player.y, 6, 4, 0);
	path_start(path, 6, path_action_stop, true);
}