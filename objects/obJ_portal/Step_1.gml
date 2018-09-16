scale = .1*cos((pi*scaleFrame)/30)+.9;
scaleFrame = (scaleFrame + 1)%60;

light_set_multiscale(lightScaleX*scale, lightScaleY*scale);

var sw = sprite_width*scale; var sh = sprite_height*scale;
var x1 = x-(.5*sw); var y1 = y - (.5*sh);
var x2 = x1 + sw; var y2 = y1 + sh;
part_emitter_region(system, emitter, x1,x2,y1,y2,ps_shape_rectangle,ps_distr_gaussian);
part_emitter_burst(system, emitter, part, 10);