with obj_player {
	
	if !variable_instance_exists(id, "level") exit;
	
	if level == 1 && xp == 0 && xpTemp == 0 {
		global.doNotDisplayTutorialMessages = false;
	}
}