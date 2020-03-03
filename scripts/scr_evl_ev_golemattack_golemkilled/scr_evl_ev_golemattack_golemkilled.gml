/// scr_evl_ev_golemattack_golemkilled(arr) 
/// @param arr

var arr = argument[0];

var enemykilled = arr[0];

if !variable_instance_exists(enemykilled, "enemyKey") exit;

if arrayIncludes(enemyKeys, enemykilled.enemyKey) {
	golemsSlain++;
	
	if golemsSlain == GOLEMS_TO_SLAY_COUNT {
		status = EventStepStatus.Completed;
	}
}