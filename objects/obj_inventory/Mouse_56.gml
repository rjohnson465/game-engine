var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if !global.ui.isShowingMenus exit;
if global.ui.currentMenu != INVENTORY exit;

// cycle through buttons and see if we've clicked on one
var currentButton = ds_map_find_first(menuButtonCoordinates);
for (var i = 0; i < ds_map_size(menuButtonCoordinates); i++) {
	var arr = ds_map_find_value(menuButtonCoordinates,currentButton);
	var x1 = arr[0];
	var y1 = arr[1];
	var x2 = arr[2];
	var y2 = arr[3];
	
	if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
		switch (currentButton) {
			case "InventoryScrollUp":{
				if scrollLevel != 0 {
					scrollLevel--;
					audio_play_sound(snd_ui_click1,1,0);
				}
				break;
			}
			case "InventoryScrollDown":{
				//var inv = global.player.inventory;
				if !is_undefined(ds_list_find_value(inv, 19 + (5*scrollLevel))) {
					scrollLevel++;
					audio_play_sound(snd_ui_click1,1,0);
				}
				break;
			}
			case InventoryFilters.None: {
				filter = InventoryFilters.None;
				audio_play_sound(snd_ui_tab2,1,0);
				break;
			}
			case InventoryFilters.Melee: {
				filter = InventoryFilters.Melee;
				audio_play_sound(snd_ui_tab2,1,0);
				break;
			}
			case InventoryFilters.Ranged: {
				filter = InventoryFilters.Ranged;
				audio_play_sound(snd_ui_tab2,1,0);
				break;
			}
			case InventoryFilters.Other: {
				filter = InventoryFilters.Other;
				audio_play_sound(snd_ui_tab2,1,0);
				break;
			}
			case InventoryFilters.Shields: {
				filter = InventoryFilters.Shields;
				audio_play_sound(snd_ui_tab2,1,0);
				break;
			}
			case InventoryFilters.Rings: {
				filter = InventoryFilters.Rings;
				audio_play_sound(snd_ui_tab2,1,0);
				break;
			}
			case InventoryFilters.Head: {
				filter = InventoryFilters.Head;
				audio_play_sound(snd_ui_tab2,1,0);
				break;
			}
			
		}
	}
	
	currentButton = ds_map_find_next(menuButtonCoordinates,currentButton);
}