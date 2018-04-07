if distance_to_object(obj_player) < 20 && global.player.isAlive && !global.canLoot && !global.isWishing {
	if !isRunning {
		drawPrompt("Fill Fountain",Input.F);
	}
	if isDoneFilling {
		drawPrompt("Wish At Fountain",Input.F);
	}
}

if inUse {
	draw_set_color(c_gray);
	draw_rectangle(100,100,400,400,0);
}