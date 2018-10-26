/// moveLootItemSelector(direction)
/// @param direction "up" | "left" | "down" | "right"
/// must be called by obj_item_drop

var dir = argument[0];

if global.ui.isShowingMenus exit; // menus take priority over loot

if !items exit;
if !isBeingLooted exit;

var closestItem = selectedItem; var closestDist = 10000;
for (var i = 0; i < ds_list_size(items); i++) {
//with obj_skill_parent {

	var item = ds_list_find_value(items,i);
	
	var distToSelectedItem = point_distance(item.x1,item.y1,selectedItem.x1,selectedItem.y1);
	
	if distToSelectedItem < closestDist {
		var doSwitch = false;
		switch dir {
			case "up" : {
				if item.y1 < selectedItem.y1 doSwitch = true; break;
			}
			case "down" : {
				if item.y1 > selectedItem.y1 doSwitch = true; break;
			}
			case "left" : {
				if item.x1 < selectedItem.x1 doSwitch = true; break;
			}
			case "right" : {
				if item.x1 > selectedItem.x1 doSwitch = true; break;
			}
		}
		if doSwitch {
			closestDist = distToSelectedItem;
			closestItem = item;
		}
	}
}
selectedItem = closestItem;
/*
x1 = closestSkill.x1;
y1 = closestSkill.y1;