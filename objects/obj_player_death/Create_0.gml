window_set_cursor(cr_default);
global.ui.grabbedItem = noone;
cursor_sprite = -1;
draw_set_color(c_white);

uni_time = shader_get_uniform(shd_greyscale,"time");
var_time_var = 0;

uni_mouse_pos = shader_get_uniform(shd_greyscale,"mouse_pos");
var_mouse_pos_x = mouse_x - camera_get_view_x(0);
var_mouse_pos_y = mouse_y - camera_get_view_y(0);

uni_resolution = shader_get_uniform(shd_greyscale,"resolution");
//var_resolution_x = camera_get_view_width(0);
//var_resolution_y = camera_get_view_height(0);

var_resolution_x = view_get_wport(0);
var_resolution_y = view_get_hport(0);

uni_greyscale_fade = shader_get_uniform(shd_greyscale,"fade");
var_greyscale_fade = 0.0;

shader_enabled = true;
full_screen_effect = true;

room_speed = 15;

textFadeFrame = 0;
textFadeTotalFrames = 30;
acceptingInput = false;

enum ReviveOptions {
	Fountain,
	Orb
}
selectedOption = ReviveOptions.Fountain;

application_surface_draw_enable(false);

reviveAtFountainButtonCoordinates = [];
reviveWithOrbButtonCoordinates = [];
mouseOverFountainRevive = false;
mouseOverOrbRevive = false;
fade = noone;

reviveOrbs = noone;
for (var i = 0; i < ds_list_size(global.player.inventory); i++) {
	var el = ds_list_find_value(global.player.inventory,i);
	if el.object_index == obj_item_revive_orb {
		reviveOrbs = el;
	}
}

with obj_enemy_parent {
	showHp = false;
}

// however we revive, we should make sure all objects get their destroy / cleanup stuff
// since death always ends with a fade, this global will be set to false once fade stops
global.activateAll = true;
