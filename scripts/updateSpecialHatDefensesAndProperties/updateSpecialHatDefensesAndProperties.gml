/// updateSpecialHatDefensesAndProperties()

/// must be called by a hat obj

if !object_is_ancestor(object_index, obj_hat_parent) || !isSpecialHat exit;

// Set the special hat's Defenses based on NarrativeState
// if in Act 1, act 1 stats, act 2, act 2 states, so on...
var currentAct = getActForNarrativeState();
var defensesArray = ds_map_find_value(specialHatDefenses, currentAct);
var propsArray = ds_map_find_value(specialHatProperties, currentAct);

var wasEquipped = false;
if equipmentSlot != noone {
	wasEquipped = true;
}
// if the hat was equipped, unequip it
if wasEquipped {
	unequipItem(id);
}

// update defenses based on act
for (var i = 0; i < array_length_1d(defensesArray); i++) {
	var arr = defensesArray[i];
	var defType = arr[0];
	var defAmount = arr[1];
	ds_map_replace(defenses, defType, defAmount);
}

// update properties based on act
for (var i = 0; i < array_length_1d(propsArray); i++) {
	var arr = propsArray[i];
	var prop = arr[0];
	var val = arr[1];
	ds_map_replace(itemProperties, prop, val);
}

// maybe re-equip hat
if wasEquipped {
	equipItem(id, EquipmentSlots.Head);
}