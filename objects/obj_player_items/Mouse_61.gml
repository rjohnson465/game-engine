
if mouseOverGuiRect(invTopLeftX,invTopLeftY,invBottomRightX,invBottomRightY) {
	// do not keep scrolling down if last shown row contains last item in player inventory
	if !is_undefined(ds_list_find_value(inv, 20 + (5*scrollLevel))) {
		scrollLevel++;
	}
}