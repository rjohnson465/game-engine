/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if status != ExerciseStepStatus.InProgress exit;

var shieldEquipped = false;
if	getItemInEquipmentSlot(EquipmentSlots.RightHand1).object_index == obj_hand_item_woodshield ||
	getItemInEquipmentSlot(EquipmentSlots.RightHand2).object_index == obj_hand_item_woodshield {
	
		shieldEquipped = true;
	}

// teach how to get to ranged weapons tab and equip bow, if ui is showing
if global.ui.isShowingMenus {
	
	if shieldEquipped {
		// prompt player to get out of the menu ui
		var msgC = "Exit player UI with either the B button or Start button.";
		var msgMk = "Exit player UI with the Escape key, or by clicking on the top right X button.";
		drawTutorialMessage(400, 500, msgC, msgMk, [spr_prompt_xbox_b, spr_prompt_xbox_start], [spr_prompt_mk_escape]);
	} else {
		if global.ui.currentMenu == INVENTORY {
			// if current filter is not melee, show how to get to melee filter
			if global.inventory.filter != InventoryFilters.Melee {
				// draw flashing rectangle around ranged filter
				var posArr = noone;
				with global.inventory {
					posArr = getFilterPosition(InventoryFilters.Melee);
				}
				if posArr == noone exit;
		
				var x1 = posArr[0]; var y1 = posArr[1];
				var x2 = x1 + 30; var y2 = y1 + 30;
		
				draw_set_color(c_aqua);
				draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
				draw_rectangle_width(x1, y1, x2, y2, 3);
				draw_set_alpha(1);

				var msgC = "Navigate to the Melee weapons filter (using the left / right bumpers).";
				var msgMk = "Navigate to the Melee weapons filter (click on it).";
				drawTutorialMessage(400, 275, msgC, msgMk, [spr_prompt_xbox_lb, spr_prompt_xbox_rb], []);

			} else {
				var msgC = "Equip your shield with the A button.";
				var msgMk = "Equip your shield by dragging to to an acceptable slot.";
				drawTutorialMessage(300, 275, msgC, msgMk, [spr_prompt_xbox_a], [spr_prompt_mk_mouse]);
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