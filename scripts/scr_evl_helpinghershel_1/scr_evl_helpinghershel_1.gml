/// scr_evl_helpinghershel_1(arr)

// called by first quest step of helping hershel quest, when any event is started

var arr = argument[0];

var ev = arr[0];

if ev.object_index == obj_event_saving_hershel {
	// take clayheart and change current quest description
	description = "Save Hershel from the dybbuks!";
	var clayheart = instance_nearest(x, y, obj_item_clayheart);
	destroyItem(clayheart, false);
}