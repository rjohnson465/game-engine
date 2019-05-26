// items on belt will move when belt is active

itemsOnBelt = ds_list_create();

with obj_item_drop_persistent {
	if distance_to_object(other) < 5 && layer == other.origLayer {
		ds_list_add(other.itemsOnBelt, id); 
	}
}