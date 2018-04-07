if distance_to_object(obj_player) < 20 && global.player.isAlive && !global.canLoot && !global.isWishing {
	if !isRunning {
		drawPrompt("Fill Fountain",Input.F);
	}
	if isDoneFilling {
		drawPrompt("Wish At Fountain",Input.F);
	}
}
