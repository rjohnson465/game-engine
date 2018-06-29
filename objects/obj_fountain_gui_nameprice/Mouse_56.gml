if global.fountainGui.currentSubMenu != NAMEPRICE exit;

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

// cycle through buttons and see if we've clicked on one
var currentButton = ds_map_find_first(menuButtonCoordinates);
for (var i = 0; i < ds_map_size(menuButtonCoordinates); i++) {
	var arr = ds_map_find_value(menuButtonCoordinates,currentButton);
	var x1 = arr[0];
	var y1 = arr[1];
	var x2 = arr[2];
	var y2 = arr[3];
	
	var newProposal = namedPrice;
	if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
		if currentButton != "Back" && currentButton != WISH {
			audio_play_sound(snd_item_coins,1,0);
		}
		switch (currentButton) {
			case "Back": {
				goBackFromNamePrice(); exit;
			}
			case WISH: {
				audio_play_sound(snd_fountain_repair,1,0);
				if global.fountainGui.currentMenu == INSERTGEM {
					attemptGemInsertion();
				} else if global.fountainGui.currentMenu == BREAKDOWNITEM {
					attemptItemBreakDown();
				} else if global.fountainGui.currentMenu == REPAIRITEM {
					attemptRepairItem();
				}
				exit;
			}
			case RESETPRICE: {
				newProposal = 0; break;
			}
			case INCREASE100: {
				newProposal += 100; break;
			}
			case INCREASE1K: {
				newProposal += 1000; break;
			}
			case INCREASE10K: {
				newProposal += 10000; break;
			}
			case INCREASE100K: {
				newProposal += 100000; break;
			}
			case INCREASE1M: {
				newProposal += 1000000; break;
			}
		}
		if currentButton != WISH {
			if newProposal < getGoldCount() {
				namedPrice = newProposal;
			} else {
				alert("You do not have enough gold", c_red);
			}
		}
	}
	
	if ds_map_size(menuButtonCoordinates) != -1 {	
		currentButton = ds_map_find_next(menuButtonCoordinates,currentButton);
	} else break;
}

