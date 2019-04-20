event_inherited();

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);
var pad = global.player.gamePadIndex;
var bScale = .625; // draw items at .625 scale, so they line up with attunements
var slotWidth = sprite_get_width(spr_item_slot);
var bSlotWidth = slotWidth * bScale;
var attunementsY = gamepad_is_connected(pad) ? vh - 108 : vh - 108 - bSlotWidth;

y1 = vy + attunementsY;
y = y1;;