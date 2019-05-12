var totalHeight = 0;
draw_set_font(font_main);
var s = "string";
var sh = string_height(s);
for (var i = 0; i < numFloors; i++) {
	totalHeight += sh;
}

var handleHeight = 15;
totalHeight += handleHeight; // handle height
totalHeight += 5; // padding
var totalWidth = 200;

// draw window
draw_set_color(c_gray); draw_set_alpha(.75);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
var tlx = vw /2; var tly = vh / 2;
draw_rectangle(tlx, tly, tlx + totalWidth, tly + totalHeight, 0);

// handle
draw_set_color(C_HANDLES);
draw_set_alpha(1);
draw_rectangle(tlx, tly, tlx + totalWidth, tly + handleHeight, 0);
draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
draw_text(mean(tlx, tlx + totalWidth), mean(tly, tly + handleHeight), "Select Floor");

// draw floors
var yy = tly + handleHeight + 5;
var xx = tlx + 15;
var pad = global.player.gamePadIndex;
for (var i = 0; i < numFloors; i++) {
	var f = i+1;
	draw_set_halign(fa_left); draw_set_valign(fa_top);
	var s = "Floor " + string(f);
	var sw = string_width(s);
	var sh = string_height(s);
	
	// m/k interaction
	if !gamepad_is_connected(pad) {
		if mouseOverGuiRect(xx, yy, xx+sw, yy+sh) {
			draw_set_color(c_white);
			selectedFloor = f;
			if mouse_check_button_pressed(mb_left) {
				associatedElevator.elevatorFloorToMoveTo = f;
				alarm[0] = 3;
				hasSetAlarm = true;
			}
		} else {
			draw_set_color(c_ltgray);
		}
	}
	// controller interaction
	else {
		if selectedFloor == f {
			draw_set_color(c_white);
		} else {
			draw_set_color(c_ltgray);
		}
	}
	
	draw_text(xx, yy, s);
	yy += sh + 5;
}