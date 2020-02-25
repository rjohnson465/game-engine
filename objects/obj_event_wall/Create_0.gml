lightScaleX = image_xscale / 2;
lightScaleY = image_yscale / 2;
scale = 1;
scaleFrame = 0;
scaleTotalFrames = 60;

event_inherited();

light_create_layer_multiscale(spr_light_square, lightScaleX, lightScaleY, c_aqua, .75, image_angle, true);

part = part_type_create();
system = part_system_create();
emitter = part_emitter_create(system);

part_type_shape(part, pt_shape_smoke);
part_type_alpha2(part,.5,.2);
part_type_color2(part,c_silver,c_white);
part_type_orientation(part,0,0,0,15,1);
part_type_size(part,0.3,0.50,0,0);
part_type_speed(part,.1,.4,0,0);
part_type_direction(part,0,360,0,4);
part_type_life(part,60,90);

var sw = sprite_width; var sh = sprite_height;
var x1 = x - lengthdir_x((.5*sw), image_angle); var y1 = y - lengthdir_y((.5*sh), image_angle);
var x2 = x1 + lengthdir_x(sw, image_angle); var y2 = y1 + lengthdir_y(sh, image_angle);

var a = image_angle;

// bottom mid
var bx = x + lengthdir_x(sh*.5, a + 90);
var by = y + lengthdir_y(sh*.5, a + 90);

// top mid
var tx = x - lengthdir_x(sh*.5, a + 90);
var ty = y - lengthdir_y(sh*.5, a + 90);

// bottom right
var brx = bx + lengthdir_x(sw*.5, a);
var bry = by + lengthdir_y(sw*.5, a);

// bottom left 
var blx = bx - lengthdir_x(sw*.5, a);
var bly = by - lengthdir_y(sw*.5, a);

// top left
var tlx = tx - lengthdir_x(sw*.5, a);
var tly = ty - lengthdir_y(sw*.5, a);

// top right
var trx = tx + lengthdir_x(sw*.5, a);
var try = ty + lengthdir_y(sw*.5, a);

part_emitter_region(system, emitter, bbox_left , bbox_right, bbox_top, bbox_bottom ,ps_shape_rectangle, ps_distr_gaussian);

part_system_depth(system, layer_get_depth(layer));

key = fs_generate_key(id);

// a portal can be blocked untraversable 
isUntraversable = false;
origSpriteIndex = sprite_index;
postX = x; postY = y;