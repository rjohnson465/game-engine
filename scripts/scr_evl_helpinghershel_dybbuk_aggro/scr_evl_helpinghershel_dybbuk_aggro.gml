/// scr_evl_helpinghershel_dybbuk_aggro(arr)
/// @param arr

var arr = argument[0];

var victim = arr[0];

if victim == id {
	isAggroed = true;
	// will deaggro in x seconds
	var evstep = instance_nearest(x, y, obj_evstep_saving_hershel_1);
	alarm[3] = evstep.GHOST_TIME_TO_DEAGGRO;
	hasSetUnaggroAlarm = true;
}