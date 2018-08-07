/// appraiseRing(ring)
/// @param ring

var ring = argument[0];

var value = 0;

var vRarePts = 0; var rarePts = 0; var basicPts = 0;
// vrarePts*1000, rarePts*500, basicPts*100
var currentProp = ds_map_find_first(ring.itemProperties);
for (var i = 0; i < ds_map_size(ring.itemProperties); i++) {
	
	if arrayIncludes(global.vrareItemProperties, currentProp) {
		var arr = ds_map_find_value(global.itemPropertyRangesForPts, currentProp);
		var minVal = arr[0]; var maxVal = arr[1];
		var val = ds_map_find_value(ring.itemProperties, currentProp);
		if val == minVal val = minVal+1;
		if is_array(val) val = val[1];
		var pts = (val-minVal)/((maxVal-minVal)/global.a1MaxPtsVal);
		vRarePts += pts;
	}
	
	if arrayIncludes(global.rareItemProperties, currentProp) {
		var arr = ds_map_find_value(global.itemPropertyRangesForPts, currentProp);
		var minVal = arr[0]; var maxVal = arr[1];
		var val = ds_map_find_value(ring.itemProperties, currentProp);
		if val == minVal val = minVal+1;
		if is_array(val) val = val[1];
		var pts = (val-minVal)/((maxVal-minVal)/global.a1MaxPtsVal);
		rarePts += pts;
	}
	
	if arrayIncludes(global.basicItemProperties, currentProp) {
		var arr = ds_map_find_value(global.itemPropertyRangesForPts, currentProp);
		var minVal = arr[0]; var maxVal = arr[1];
		var val = ds_map_find_value(ring.itemProperties, currentProp);
		if val == minVal val = minVal+1;
		if is_array(val) val = val[1];
		var pts = (val-minVal)/((maxVal-minVal)/global.a1MaxPtsVal);
		basicPts += pts;
	}
	
	currentProp = ds_map_find_next(ring.itemProperties, currentProp);
}

value += round((vRarePts*1000));
value += round(rarePts*500);
value += round(basicPts*100);

return value;