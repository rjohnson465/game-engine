/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if status != ExerciseStepStatus.InProgress exit;

var pad = global.gamePadIndex;
var ql = global.questLog;
// teach how to get to melee weapons tab and equip weapon, if ui is showing
if global.ui.isShowingMenus {
	
	if ql.watchedQuest != noone {
		// prompt player to get out of the menu ui
		var msgC = "Exit player UI with either the B button or Start button.";
		var msgMk = "Exit player UI with the Escape key, or by clicking on the top right X button.";
		drawTutorialMessage(400, 500, msgC, msgMk, [spr_prompt_xbox_b, spr_prompt_xbox_start], [spr_prompt_mk_escape]);
	} else {
	
		if global.ui.currentMenu == SKILLS {
			// if in skills menu (and using controller) direct player to quest log
			if gamepad_is_connected(pad) && !ql.isActive {
				// draw flashing rectangle around quest log area
			
		
				var x1 = ql.topLeftX; var y1 = ql.topLeftY;
				var x2 = ql.bottomRightX; var y2 = ql.bottomRightY;
		
				draw_set_color(c_aqua);
				draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
				draw_rectangle_width(x1, y1, x2, y2, 3);
				draw_set_alpha(1);

				var msgC = "Navigate to your Quest Log with right bumper (or D pad)";
				var msgMk = "Navigate to your Quest Log";
				drawTutorialMessage(400, 225, msgC, msgMk, [spr_prompt_xbox_rb], []);

			} else {
				// currently selected quest must be wamdk
				if ql.selectedQuest.object_index == obj_quest_wamdk {
					var msgC = "This is the quest Barry gave you. You can read about it any time here. Press Y to watch a quest. When a quest is watched, your current objective will always appear in the top right corner of the screen. Try it now.";
					var msgMk = "This is the quest Barry gave you. You can read about it any time here. Click the eye icon to watch a quest. When a quest is watched, your current objective will always appear in the top right corner of the screen. Try it now.";
					drawTutorialMessage(850, 450, msgC, msgMk, [spr_prompt_xbox_y], [spr_prompt_mk_mouse]);
				}
			}
		} else {
			// direct player to skills tab
			// draw flashing rectangle around skills tab
			var posArr = noone;
			with global.ui {
				posArr = getMenuTabPosition(SKILLS);
			}
			if posArr == noone exit;
		
			var x1 = posArr[0]; var y1 = posArr[1]; var tabW = posArr[2];
			var x2 = x1 + tabW; var y2 = y1 + global.ui.menuTabsHeight;
		
			draw_set_color(c_aqua);
			draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
			draw_rectangle_width(x1, y1, x2, y2, 3);
			draw_set_alpha(1);

			var msgC = "Navigate to the Skills / Quests tab (using the left / right triggers).";
			var msgMk = "Navigate to the Skills / Quests tab (click on it).";
			drawTutorialMessage(400, 250, msgC, msgMk, [spr_prompt_xbox_lt, spr_prompt_xbox_rt], []);
		}
	}
}