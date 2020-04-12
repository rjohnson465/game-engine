/// isRingActive(ringObjIndex)
var rObjIndex = argument[0];

if !variable_global_exists("ringsManager") return false;
if !instance_exists(global.ringsManager) return false;

var rm = global.ringsManager; 

for (var i = 0; i < array_length_1d(rm.ringsActive); i++) {
	var ring = rm.ringsActive[i];
	if instance_exists(ring) {
		if ring.object_index == rObjIndex {
			return true;
		}
	}
}

return false;