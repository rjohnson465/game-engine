/// scr_evl_exstep_mc2(arr)
/// @param arr [victim, dmgAmount, *attackObj]

// called by the unfairy used for the first combat tutorial

var arr = argument[0];
var victim = arr[0];
var attackObj = noone;
if array_length_1d(arr) >= 3 {
	attackObj = arr[2];
}
if (victim == exercise.enemy && attackObj.limbKey == "l") {
	hitsReceived++;
}