/// drawTutorialMessage(x, y, messageController, messageMk, promptsController, promptsMk)
/// @param x
/// @param y
/// @param messageController
/// @param messageMk
/// @param promptsController
/// @param promptsMk

var xx = argument[0];
var yy = argument[1];
var messageController = argument[2];
var messageMk = argument[3];
var promptSpritesController = argument[4];
var promptSpritesMk = argument[5];

exercise.isShowingAMessage = true;

var sprites = gamepad_is_connected(global.gamePadIndex) ? promptSpritesController : promptSpritesMk;
if array_length_1d(sprites) == 0 yy += sprite_get_height(spr_prompt_mk_backspace)*.35;
var spriteHeight = 0; var spritesWidth = 0;
for (var i = 0 ; i < array_length_1d(sprites); i++) {
	var sprite = sprites[i];
	spriteHeight = sprite_get_height(sprite)*.35;
	var sw = sprite_get_width(sprite)*.35;
	spritesWidth += (sw);
		
	// maybe include separator width
	if array_length_1d(promptSpritesSeparators) >= i + 1 {
		var separator = promptSpritesSeparators[i];
		var strW = string_width(separator);
		spritesWidth += strW;
	}
}
if spriteHeight != 0 spriteHeight += 5; // padding
draw_set_font(font_main); 
	
var msg = gamepad_is_connected(global.gamePadIndex) ? messageController : messageMk;
var sh = string_height_ext(msg,-1,view_get_wport(view_camera[0])/2);
var sw = string_width_ext(msg,-1,view_get_wport(view_camera[0])/2);
	
if spritesWidth > sw sw = spritesWidth;
	
draw_set_color(c_black);
var rx1 = xx-(.5*sw)-10; var ry1 = yy-(.5*sh)-10;
var rx2 = xx+(.5*sw)+10; var ry2 = yy+(.5*sh)+spriteHeight+10;
draw_rectangle(rx1,ry1,rx2,ry2,0);
messageTopLeftX = rx1; messageTopLefY = ry1;
messageBottomRightX = rx2; messageBottomRightY = ry2;
	
draw_set_color(c_aqua);
draw_rectangle(xx-(.5*sw)-10,yy-(.5*sh)-10,xx+(.5*sw)+10,yy+(.5*sh)+spriteHeight+10,1);
	
// draw name of tutorial we're in
draw_set_halign(fa_left); draw_set_valign(fa_top);
var fh = string_height("s");
scr_draw_text_outline(xx - (.5*sw) - 10, yy - (.5*sh) - 10 - fh - 5, exercise.exerciseName, c_aqua, c_white);
draw_set_halign(fa_center); draw_set_valign(fa_center);
	
draw_set_color(c_white);
// draw prompt sprites
var spritesWidthCum = 0;
var xxx = xx - (.5*spritesWidth);
for (var i = 0 ; i < array_length_1d(sprites); i++) {
	var sprite = sprites[i];
	var sw = sprite_get_width(sprite)*.35;
	var sh = sprite_get_height(sprite)*.35;
	draw_sprite_ext(sprite,1,xxx+spritesWidthCum,yy-(.25*sh),.35,.35,0,c_white,1);
	spritesWidthCum += (sw);
		
	// maybe draw separator 
	if array_length_1d(promptSpritesSeparators) >= i + 1 && array_length_1d(sprites) != i + 1 {
		var separator = promptSpritesSeparators[i];
		var strW = string_width(separator);
		var yOff = separator == "," ? .5*sh : .25*sh;
		draw_text(xxx+spritesWidthCum,yy+yOff,separator);
		spritesWidthCum += strW;
	}
}
	
draw_set_halign(fa_center); draw_set_font(font_main); draw_set_valign(fa_center);
draw_text_ext(xx,yy+spriteHeight,msg,-1,view_get_wport(view_camera[0])/2);

if variable_instance_exists(id, "exercise") && instance_exists(exercise) {
	with exercise {
		// tell where to draw the particles
		if part_system_exists(system) && part_emitter_exists(system, emitter) && part_type_exists(part) {
			var vx = camera_get_view_x(view_camera[0]);
			var vy = camera_get_view_y(view_camera[0]);
			var xmin = rx1; var xmax = rx2;
			var ymin = ry1; var ymax = ry2;
			
			
			// if region has shifted, destroy all particles and remake???
			if xmin != partRegionPrevX || ymin != partRegionPrevY {
				part_particles_clear(system);
			} 
			
			part_emitter_region(system, emitter,xmin,xmax,ymin,ymax, ps_shape_rectangle, ps_distr_gaussian);
			partRegionPrevX = xmin; partRegionPrevY = ymin;
		}
	}
}