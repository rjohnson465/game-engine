if !isGrabbed && global.ui.grabbedItem == id {
	global.ui.grabbedItem = noone;
	global.player.isEquippingBeltItem = false;
}