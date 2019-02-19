var p = global.player;
var list = p.nonPriorityInteractionPrompts;
ds_list_clear(list);

audio_stop_sound(bgmCurrent); bgmCurrent = noone;

for (var i = 0; i < ds_list_size(ambSoundIndexes); i++) {
	var ambSoundIndex = ds_list_find_value(ambSoundIndexes, i);
	audio_stop_sound(ambSoundIndex);
}

ds_list_clear(ambSoundIndexes);