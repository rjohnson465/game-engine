/// @description Insert description here
// You can write your code in this editor

if elevatorIsMoving {
	
	draw_sprite_ext(sprite_index, 1, x, y, elevatorScale, elevatorScale, image_angle, image_blend, 1);
	
} else {
	draw_self();
}