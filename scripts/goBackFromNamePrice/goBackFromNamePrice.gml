/// goBackFromNamePrice()
if global.fountainGui.currentMenu == INSERTGEM {
	global.fountainGui.currentSubMenu = CHOOSEGEM;
} else if global.fountainGui.currentMenu == BREAKDOWNITEM {
	global.fountainGui.currentSubMenu = CHOOSEITEM;
}