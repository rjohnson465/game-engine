/// getAttunementPosition(element)

// must be called by obj_player_gui

// return arr [x, y, attunementWidth]

var element = argument[0];

var arr = noone;

var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
var isDrawingAttunements = rightHandItem.chargesMax > 0 || leftHandItem.chargesMax > 0;

var pad = global.gamePadIndex;
var vh = view_get_hport(view_camera[0]);
var bScale = .625; // draw items at .625 scale, so they line up with attunements
var slotWidth = sprite_get_width(spr_item_slot);
var bSlotWidth = slotWidth * bScale;

if isDrawingAttunements {
	var attunementsY = gamepad_is_connected(pad) ? vh - 108 : vh - 108 - bSlotWidth;
	var init_x = 12; // changes on each iteration
	var final_x = init_x + (array_length_1d(global.ALL_ELEMENTS)*sprite_get_width(spr_attunement_fire));
	global.y1 = 658; // used for attunement instance creation
	for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
		var el = global.ALL_ELEMENTS[i];
		var attunementSpriteIndex = asset_get_index("spr_attunement_"+el);
		var x1 = init_x + (i*40);
		
		if el == element {
			arr = [x1, attunementsY, sprite_get_width(spr_attunement_fire)];
		}
	}
}

return arr;