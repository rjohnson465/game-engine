if ds_exists(inv, ds_type_list) { 
	ds_list_destroy(inv); inv = -1;
}
if ds_exists(items, ds_type_list) {
	for (var i = 0; i < ds_list_size(items); i++) {
		var item = ds_list_find_value(items,i);
		if instance_exists(item) && !item.persistent {
			instance_destroy(item,1);
		}
	}
	ds_list_destroy(items); items = -1;
}
global.isTrading = false;


