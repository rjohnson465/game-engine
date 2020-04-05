/// scr_evl_savingherbie_start(arr)
/// @param arr
var arr = argument[0];

var ev = arr[0];

if ev.object_index == obj_event_saving_herbie {
	// change current quest description
	description = "Escort Herbie to Mrs. Claus";
	
	with obj_npc_herbie {
		isInteractingWithPlayer = false;
		global.isInteractingWithNpc = false;
		alarm[1] = 1;
		// refreshNpcConversations();
	}
}