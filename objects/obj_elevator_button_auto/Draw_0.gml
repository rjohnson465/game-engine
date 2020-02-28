var xs = image_xscale;
var ys = image_yscale;

if instance_exists(associatedElevator) {
	xs *= associatedElevator.elevatorScale;
	ys *= associatedElevator.elevatorScale;
}
if isActive {
	draw_sprite_ext(spr_elevatorbutton_pressed, 1, x, y, xs, ys, image_angle, image_blend, image_alpha);
} else {
	draw_sprite_ext(spr_elevatorbutton, 1, x, y, xs, ys, image_angle, image_blend, image_alpha);
}