if !isActive && type != SelectorTypes.Select exit;

if ui.isShowingMenus && ui.currentMenu == INVENTORY {
	draw_set_color(color);
	draw_rectangle(x1,y1,x1+global.inventory.slotWidth,y1+global.inventory.slotHeight,true);
	
	if type == SelectorTypes.Equip {
		draw_set_color(c_purple);
		draw_circle(x1+5,y1+5,5,false);
	}
}