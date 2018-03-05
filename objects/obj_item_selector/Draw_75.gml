if !isActive && type != SelectorTypes.Select exit;

if ui.isShowingMenus && ui.currentMenu == INVENTORY {
	draw_set_color(color);
	draw_rectangle(x1,y1,x1+global.inventory.slotWidth,y1+global.inventory.slotHeight,true);
	
	var topMidPointX = mean(x1,x1+global.inventory.slotWidth);
	draw_triangle(topMidPointX-5,y1,topMidPointX+5,y1,topMidPointX,y1+5,false);
	draw_triangle(topMidPointX-5,y1+global.inventory.slotHeight,topMidPointX+5,y1+global.inventory.slotHeight,topMidPointX,y1+global.inventory.slotHeight-5,false);
	
	var sideMidPoint = mean(y1,y1+global.inventory.slotHeight);
	draw_triangle(x1,sideMidPoint-5,x1,sideMidPoint+5,x1+5,sideMidPoint,false);
	draw_triangle(x1+global.inventory.slotWidth,sideMidPoint-5,x1+global.inventory.slotWidth,sideMidPoint+5,x1+global.inventory.slotWidth-5,sideMidPoint,false);
	
}