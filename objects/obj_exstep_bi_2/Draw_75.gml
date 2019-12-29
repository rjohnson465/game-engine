/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if status != ExerciseStepStatus.InProgress exit;

var p = global.player;
var beltHasFlask = false;
for (var i = 0; i < array_length_1d(p.beltItems); i++) {
	var it = p.beltItems[i];
	if !instance_exists(it) continue;
	if it.object_index == obj_item_healthshard {
		beltHasFlask = true;
	}
}

// teach how to get to ranged weapons tab and equip bow, if ui is showing
if global.ui.isShowingMenus {
	
	if beltHasFlask {
		// prompt player to get out of the menu ui
		var msgC = "Exit player UI with either the B button or Start button.";
		var msgMk = "Exit player UI with the Escape key, or by clicking on the top right X button.";
		drawTutorialMessage(400, 500, msgC, msgMk, [spr_prompt_xbox_b, spr_prompt_xbox_start], [spr_prompt_mk_escape]);
	} else {
		if global.ui.currentMenu == INVENTORY {
			// if current filter is not ranged, show how to get to ranged filter
			if global.inventory.filter != InventoryFilters.Other {
				// draw flashing rectangle around ranged filter
				var posArr = noone;
				with global.inventory {
					posArr = getFilterPosition(InventoryFilters.Other);
				}
				if posArr == noone exit;
		
				var x1 = posArr[0]; var y1 = posArr[1];
				var x2 = x1 + 30; var y2 = y1 + 30;
		
				draw_set_color(c_aqua);
				draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
				draw_rectangle_width(x1, y1, x2, y2, 3);
				draw_set_alpha(1);

				var msgC = "Navigate to the Misc filter (using the left / right bumpers).";
				var msgMk = "Navigate to the Misc weapons filter (click on it).";
				drawTutorialMessage(400, 275, msgC, msgMk, [spr_prompt_xbox_lb, spr_prompt_xbox_rb], []);

			} else {
				var msgC = "Usable items can be used from the Inventory screen, or they can be equipped to your belt for later use. Equip the health flask shard on your belt.";
				var msgMk = "Usable items can be used from the Inventory screen, or they can be equipped to your belt for later use. Equip the health flask shard on your belt.";
				drawTutorialMessage(500, 300, msgC, msgMk, [], []);
			}
		} else {
			// prompt player to get to the inventory tab
			// draw flashing rectangle around melee filter
			var posArr = noone;
			with global.ui {
				posArr = getMenuTabPosition(INVENTORY);
			}
			if posArr == noone exit;
		
			var x1 = posArr[0]; var y1 = posArr[1]; var tabW = posArr[2];
			var x2 = x1 + tabW; var y2 = y1 + global.ui.menuTabsHeight;
		
			draw_set_color(c_aqua);
			draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
			draw_rectangle_width(x1, y1, x2, y2, 3);
			draw_set_alpha(1);

			var msgC = "Navigate to the Inventory tab (using the left / right triggers).";
			var msgMk = "Navigate to the Inventory tab (click on it).";
			drawTutorialMessage(400, 250, msgC, msgMk, [spr_prompt_xbox_lt, spr_prompt_xbox_rt], []);
		}
	}
	
}