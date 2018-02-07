/// getEquipmentSlotObject(slotEnumVal)
/// @param slotEnumVal

var s = argument[0];

with obj_equipmentslot {
	if slot == s {
		return id;
	}
}
return noone;