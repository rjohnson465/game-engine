// if !isCurrentInteractionObject(id) exit;
if isUntraversable exit;
var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

/*
var isNearFountain = false;
with obj_fountain {
	if distance_to_object(obj_player) < 20 isNearFountain = true;
}
*/

if  //place_meeting(x,y,obj_player) && 
	global.player.currentInteractableObject == id &&
	global.player.isAlive && !isInConvo && !global.isInteractingWithNpc 
	// && !isNearFountain 
	{
	var prompt = "Enter " + nextRoomName;
	drawPrompt(prompt,Input.F, noone, noone, noone, noone, true);
}