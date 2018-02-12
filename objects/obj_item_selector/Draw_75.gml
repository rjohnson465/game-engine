if !isActive && type != SelectorTypes.Select exit;

if ui.isShowingMenus && ui.currentMenu == INVENTORY {
	draw_set_color(color);
	draw_rectangle(x1,y1,x1+global.inventory.slotWidth,y1+global.inventory.slotHeight,true);
}