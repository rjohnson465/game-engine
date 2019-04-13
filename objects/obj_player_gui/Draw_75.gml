var p = global.player;
if !p.isEquippingBeltItem exit;

var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
var leftHandItem2 = getItemInEquipmentSlot(EquipmentSlots.LeftHand2);
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
var rightHandItem2 = getItemInEquipmentSlot(EquipmentSlots.RightHand2);
var vh = view_get_hport(view_camera[0]);
var slotWidth = sprite_get_width(spr_item_slot);

// this is only for equipping belt items, must be drawn over inventory
var isDrawingAttunements = rightHandItem.chargesMax > 0 || leftHandItem.chargesMax > 0;
var bScale = .625; // draw items at .625 scale, so they line up with attunements
var bSlotWidth = slotWidth * bScale;
// draw all 5 belt item slots, with a highlighted one representing the currently selected slot for equip
var inv = global.inventory;
var initX = 12; 
var shownSlotY = vh-108-bSlotWidth-5;
// if we're not showing attunements, the shown belt slot can be a bit further down on screen
if !isDrawingAttunements {
	shownSlotY += bSlotWidth;
}
for (var i = 0; i < array_length_1d(p.beltItems); i++) {
	var item = p.beltItems[i];
	var alpha = .75;
	if inv.selectedBeltItemIndex == i {
		alpha = 1;
	}
	draw_sprite_ext(spr_item_slot, 1, initX + (i*bSlotWidth), shownSlotY, bScale, bScale, 0, c_white, alpha);
	if (item != undefined && item != noone && item > 0 && instance_exists(item)) {
		drawItem(item, initX + (i*bSlotWidth), shownSlotY, 0, bScale, alpha);
	}
}