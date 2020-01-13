/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if status != ExerciseStepStatus.InProgress exit;

// draw flashing rectangle around POISON attunement
var posArr = noone;
with global.ui {
	posArr = getAttunementPosition(POISON);
}
if posArr == noone exit;
		
var x1 = posArr[0]; var y1 = posArr[1]; var tabW = posArr[2];
var x2 = x1 + tabW; var y2 = y1 + tabW;
		
draw_set_color(c_aqua);
draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
draw_rectangle_width(x1, y1, x2, y2, 3);
draw_set_alpha(1);