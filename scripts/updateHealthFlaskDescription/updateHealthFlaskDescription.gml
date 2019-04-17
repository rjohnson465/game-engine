/// updateHealthFlaskDescription()

/// must be called by health flask object

var chargeStrength = ds_map_find_value(customItemProperties, hfs_charge_strength);
var s1 = "Restores " + string(chargeStrength) + " health per charge. Gain a single charge from wishing at fountains. Additional charges may be dropped by enemies.";
/*var chargesCount = ds_map_find_value(customItemProperties, hfs_charges);
var maxChargesCount = ds_map_find_value(customItemProperties, hfs_max_charges);
var s2 = "Current charges: " + string(chargesCount) + " / " + string(maxChargesCount);*/
description = s1;