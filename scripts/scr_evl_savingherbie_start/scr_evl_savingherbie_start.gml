/// scr_evl_savingherbie_start(arr)
/// @param arr
var arr = argument[0];

var ev = arr[0];

if ev.object_index == obj_event_saving_herbie {
	// change current quest description
	description = "Escort Herbie to Mrs. Claus";
	
	var mc = instance_nearest(x, y, obj_npc_mrsclaus);
	if instance_exists(mc) {
		mc.isInteractable = false;
	}
	
	with obj_npc_herbie {
		isInteractingWithPlayer = false;
		global.isInteractingWithNpc = false;
		alarm[1] = 1;
		isSolid = false;
		// refreshNpcConversations();
	}
}