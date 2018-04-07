if place_meeting(x,y,obj_player) && global.player.isAlive && !global.canLoot {
	var prompt = "Enter " + nextRoomName;
	drawPrompt(prompt,Input.F);
}