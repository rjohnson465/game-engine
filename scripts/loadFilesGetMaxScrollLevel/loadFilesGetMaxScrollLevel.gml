/// loadFilesGetMaxScrollLevel()

/// at what scrollLevel is the last save file shown?
/// must be called by obj_game_manager

var sl = -1;

var f = file_find_first(working_directory + "*.sav", fa_directory);

if f == "" {
	return 0;
}

var lastFileSeen = false;

while (!lastFileSeen) {
	sl++;
	var sh = string_height("s");
	
	var j = 0; 
	f = file_find_first(working_directory + "*.sav", fa_directory);
	while j < sl {
		f = file_find_next();
		j++;
	}
	
	var startY = loadBoxTopLeftY+sh;
	var maxY = loadBoxBottomRightY-sh;
	//for (var i = sl; i < ds_list_size(p.quests); i++) {
	var i = 0;
	while (true) {
		//draw_set_halign(fa_center); draw_set_valign(fa_bottom);
		var sh = string_height(f);
		var yy = startY+(i*sh);
	
		//cumY += sh;
		if yy > maxY break;
		
		f = file_find_next();
		if f == "" {
			lastFileSeen = true; break;
		}
		i++;
	}
}

return sl;