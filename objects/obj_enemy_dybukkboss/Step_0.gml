/// @description Insert description here
// You can write your code in this editor
event_inherited();

// always be bursting particles
if hp > 1 {
	if layer >= global.player.layer {
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;
		part_emitter_region(sporeSystem,sporeEmitter,x1,x2,y1,y2,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(sporeSystem,sporeEmitter,sporeParticle, 2);
	}
}