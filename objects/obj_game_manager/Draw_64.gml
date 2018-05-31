if room == room0 {

	
	// get all save files
	var i = 0;
	var fileName = file_find_first(working_directory + "*.sav",fa_directory);

	while fileName != ""
	{
	    draw_text(500,i*50,fileName);
	    fileName = file_find_next();
	    i += 1;
	}

	file_find_close();
}

