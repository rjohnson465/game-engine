depth = -10000;

enum TitleScreenState {
	Options,
	Load
}

state = TitleScreenState.Options;
isLoading = false;
currentSaveFile = "Game.sav";
roomToGoTo = noone;
isReadyToMoveRooms = false;