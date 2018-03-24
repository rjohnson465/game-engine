/// getSlotAtSelector(id)
/// @param id

var selector = argument[0];

with obj_equipmentslot {
	if x1 == selector.x1 && y1 == selector.y1 {
		return id;
	}
}
return noone;