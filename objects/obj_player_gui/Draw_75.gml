if room == game_menu exit;
var p = global.player;
var pad = p.gamePadIndex;
if !p.isEquippingBeltItem exit;

var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
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
if gamepad_is_connected(pad) {
	for (var i = 0; i < array_length_1d(p.beltItems); i++) {
		var item = p.beltItems[i];
		var drawDark = false;
		if inv.selectedBeltItemIndex == i {
			drawDark = true;
		}
		draw_sprite_ext(spr_item_slot, 1, initX + (i*bSlotWidth), shownSlotY, bScale, bScale, 0, c_green, 1);
		if drawDark {
			draw_sprite_ext(spr_item_slot, 1, initX + (i*bSlotWidth), shownSlotY, bScale, bScale, 0, c_black, .5);
		}
		if (item != undefined && item != noone && item > 0 && instance_exists(item)) {
			drawItem(item, initX + (i*bSlotWidth), shownSlotY, 0, bScale, 1);
		}
	}
} 
// draw equipping mode belt items, m/k
else {
	var y1 = vh - 108;
	for (var i = 0; i < array_length_1d(p.beltItems); i++) {
		var x1 = initX + (i * bSlotWidth); 
		var item = p.beltItems[i];
		var drawDark = false;

		// if mouse over belt item slot while belt equipping, draw that slot darker
		if mouseOverGuiRect(x1, y1, x1+bSlotWidth, y1 + bSlotWidth) {
			drawDark = true;
			inv.selectedBeltItemIndex = i;
				
			if mouse_check_button_released(mb_left) {
				var usableItem = global.ui.grabbedItem;
				with inv {
					equipBeltItem(i, usableItem);
				}
				p.isEquippingBeltItem = false;
			}
			
			if mouse_check_button_pressed(mb_right) {
				unequipBeltItem(i);
			}
			
		}
		
		draw_sprite_ext(spr_item_slot, 1, initX + (i*bSlotWidth), y1, bScale, bScale, 0, c_green, 1);
		if drawDark {
			draw_sprite_ext(spr_item_slot, 1, initX + (i*bSlotWidth), y1, bScale, bScale, 0, c_black, .5);
		}
		if (item != undefined && item != noone && item > 0 && instance_exists(item)) {
			drawItem(item, initX + (i*bSlotWidth), y1, 1, bScale, 1, 0);
		}
	}
}