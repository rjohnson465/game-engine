/// questLogGetMaxScrollLevel()

/// at what scrollLevel is the last quest in player.quests shown?
/// since quests appear in variable heights, this is a nontrivial problem
/// must be called by obj_quest_log

var sl = -1;
var p = global.player;

if ds_list_size(p.quests) == 0 {
	return 0;
}

var lastQuestSeen = false;

while (!lastQuestSeen) {
	sl++;
	var sh = string_height("s");
	var cumY = aqTopLeftY+sh+5; var maxY = MENUS_BOTTOMRIGHT_Y-sh-10;
	for (var i = sl; i < ds_list_size(p.quests); i++) {
		
		draw_set_halign(fa_center); draw_set_valign(fa_bottom);
		var maxW = aqBottomRightX-aqTopLeftX-2-scrollBarWidth;
		var quest = ds_list_find_value(p.quests,i);
		var s = quest.name; var sh = string_height_ext(s,-1,maxW);
	
		cumY += sh+5;
		if cumY > maxY break;
		
		if i == ds_list_size(p.quests)-1 {
			lastQuestSeen = true; break;
		}
	
	}
}

return sl;