if !isCurrentInteractionObject(id) exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
var isNearFountain = false;
with obj_fountain {
	if distance_to_object(obj_player) < 20 isNearFountain = true;
}
if place_meeting(x,y,obj_player) && global.player.isAlive && !global.canLoot && !isInConvo && !global.canInteractWithNpc && !global.isInteractingWithNpc && !isNearFountain {
	var prompt = "Enter " + nextRoomName;
	drawPrompt(prompt,Input.F);
}