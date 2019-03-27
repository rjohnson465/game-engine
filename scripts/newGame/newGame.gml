/// newGame()
// starts a new game, must be called from game manager
currentSaveFile = newGameName + ".sav";
with global.player {
	global.playerDoNothing = false;
	event_perform(ev_create, 0);
	global.player.layerToMoveTo = "instances_floor_1";
	
	
	
	x = 160;
	y = 415;
	gamePadIndex = global.gamePadIndex;
	with obj_light_radius {
		if owner == global.player {
			persistent = true;
		}
	}
	global.roomName = getRoomName(rm_forest);
	instance_create_depth(x,y,1,obj_room_text);
}
global.newGameStarted = true;
room_goto(rm_forest);