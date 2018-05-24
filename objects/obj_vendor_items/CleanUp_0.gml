ds_list_destroy(inv);
for (var i = 0; i < ds_list_size(items); i++) {
	var item = ds_list_find_value(items,i);
	item.x1 = -50;
	item.y1 = -50;
}
//ds_list_destroy(items);