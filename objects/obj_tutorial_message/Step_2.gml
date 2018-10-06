/// @description Insert description here
// You can write your code in this editor
// particles
if origLayer >= global.player.layer {
	part_emitter_region(system,emitter,bbox_left,bbox_right,bbox_top,bbox_bottom,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(system,emitter,particle, -1);
}