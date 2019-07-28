// scr_rob_take_wires

var pinv = global.player.inventory;
for (var i = 0; i < ds_list_size(global.player.inventory); i++) {
	var item = ds_list_find_value(pinv, i);
	if item.object_index == obj_item_wire_rg{
		destroyItem(item, false);
		i = 0;
	}
}

alert("Rob takes the red and green wire", c_yellow);