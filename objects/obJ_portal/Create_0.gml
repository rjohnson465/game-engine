nextRoom = noone;
nextRoomX = noone;
nextRoomY = noone;
nextRoomLayer = noone;
nextRoomName = noone;

lightScaleX = image_xscale / 2;
lightScaleY = image_yscale / 2;
scale = 1;
scaleFrame = 0;
scaleTotalFrames = 60;

light_create_layer_multiscale(spr_light_square, lightScaleX, lightScaleY, C_GOLD, .75, 0, true);

part = part_type_create();
system = part_system_create();
emitter = part_emitter_create(system);

part = part_type_create();
part_type_shape(part, pt_shape_sphere);
part_type_alpha2(part,1,.2);
part_type_color2(part,c_dkgray,c_silver);
part_type_orientation(part,0,0,0,15,1);
part_type_size(part,0,0.10,0,0);
part_type_speed(part,.5,2,0,0);
part_type_direction(part,0,360,0,4);
part_type_life(part,5,15);

var sw = sprite_width; var sh = sprite_height;
var x1 = x-(.5*sw); var y1 = y - (.5*sh);
var x2 = x1 + sw; var y2 = y1 + sh;
part_emitter_region(system, emitter, x1,x2,y1,y2,ps_shape_rectangle,ps_distr_gaussian);

part_system_depth(system, layer_get_depth(layer));