if !isActive && type != SelectorTypes.Select exit;

if ui.isShowingMenus && ui.currentMenu == INVENTORY {
	drawSelector(x1,y1,color);
}
