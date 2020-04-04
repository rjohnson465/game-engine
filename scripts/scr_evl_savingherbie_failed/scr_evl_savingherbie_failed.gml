/// scr_evl_savingherbie_failed(arr)
/// @param arr
var arr = argument[0];

var ev = arr[0];

if ev.object_index == obj_event_saving_herbie {
	// change current quest description
	description = "Herbie fled. Find him back at the wolf den to try again.";
	
	with obj_npc_herbie {
		x = initialPostX;
		y = initialPostY;
		path_end();
		speed = 0;
		
	}
	
	with obj_npc_parent {
		refreshNpcConversations();
	}
}