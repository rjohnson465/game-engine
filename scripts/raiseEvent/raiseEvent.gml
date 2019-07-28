/// raiseEvent(eventName, eventParametersArray)
/// @param eventName
/// @param eventParametersArray

var evName = argument[0];
var evParams = argument[1];

with all {
	if variable_instance_exists(id, "eventListeners") {
		if ds_exists(eventListeners, ds_type_map) {
			var func = ds_map_find_value(eventListeners, evName);
			if func > 0 {
				script_execute(func, evParams);
			}
		}
	}
}