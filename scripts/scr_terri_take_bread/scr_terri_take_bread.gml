// scr_terri_take_bread

var pinv = global.player.inventory;
for (var i = 0; i < ds_list_size(global.player.inventory); i++) {
	var item = ds_list_find_value(pinv, i);
	if item.object_index == obj_item_bread {
		destroyItem(item, false);
		i = 0;
	}
}

audio_play_sound(snd_item_cloth, 1, 0);
// alert("Terri takes the bread from you", c_yellow);