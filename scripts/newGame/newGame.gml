// starts a new game, must be called from game manager
currentSaveFile = newGameName + ".sav";
with global.player {
	global.playerDoNothing = false;
	event_perform(ev_create, 0);
	global.player.layerToMoveTo = "instances_floor_1";
	x = 300;
	y = 300;
	gamePadIndex = global.gamePadIndex;
}
room_goto(rm_dungeon);