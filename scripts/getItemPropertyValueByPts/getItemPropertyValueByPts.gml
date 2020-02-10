/// getItemPropertyValueRangeByPts(prop, pts, act)
/// @param prop
/// @param pts
/// @param act

var prop = argument[0];
var pts = argument[1];
var act = argument[2];

var val = 0;

var a1MaxPtsVal = global.a1MaxPtsVal;
// we calculate the effect by act1 vals, then multiply by act
var arr = ds_map_find_value(global.itemPropertyRangesForPts, prop);
var minVal = arr[0]; var maxVal = arr[1];

val = (((maxVal-minVal)/a1MaxPtsVal)*pts)+minVal;

if prop != ModifiableProperties.HpRegen && prop != ModifiableProperties.StaminaRegen {
	val = round(val);
}
return val;


