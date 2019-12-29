/// scr_evl_exstep_mc3(arr)
/// @param arr [victim, dmgAmount, *attackObj]

// called by the player -- make sure player is blocking attacks

var arr = argument[0];
var victim = arr[0];

if (victim == global.player && victim.isShielding) {
	blocksPerformed++;
}