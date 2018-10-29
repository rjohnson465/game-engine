/// alertQuestComplete(quest)
/// @param quest instance

var quest = argument[0];

alert("Quest Complete: " + quest.name, c_lime);

// force room start event to maybe add conversation to list
with obj_npc_parent {
	event_perform(ev_other, ev_room_start);
}