// scr_rob_take_wires

var pinv = global.player.inventory;
for (var i = 0; i < ds_list_size(global.player.inventory); i++) {
	var item = ds_list_find_value(pinv, i);
	if item.object_index == obj_item_wire_b || item.object_index == obj_item_wire_w || item.object_index == obj_item_wire_r {
		destroyItem(item, false);
		i = 0;
	}
}

audio_play_sound(snd_item_cloth, 1, 0);
alert("Rob takes the 3 wires from you", c_yellow);