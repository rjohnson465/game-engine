/// useItem(item)
/// @param item
/// item must be usable

var item = argument[0];
if item == noone exit;
with item {
	alert("Used " + name,c_yellow);
	isInUse = true;
	audio_play_sound(soundUse,1,0);
}