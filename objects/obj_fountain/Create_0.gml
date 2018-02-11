depth = 10;

// Make a circle with 16 points.
/*var n = 16
var gap = 360 / n;
var pointsx = ds_list_create()
var pointsy = ds_list_create()
for (var i = 0; i < n; i++) {
    ds_list_add(pointsx, lengthdir_x(sprite_get_width(sprite_index) / 2 + 1, i * gap))
    ds_list_add(pointsy, lengthdir_y(sprite_get_width(sprite_index) / 2 + 1, i * gap))
}
light_create_caster_from_points(pointsx, pointsy);*/

isRunning = false;
isDoneFilling = false;

lightRadius = 256;
lightRadiusAlpha = .35;
lightRadiusScale = .75;
lightRadiusColor = c_aqua;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;

nativeRoom = room;

postX = x;
postY = y;


system = part_system_create();
part_system_depth(system,-4);
emitter = part_emitter_create(system);
particle = noone;

num = random_range(10,25);
// water particle
var water = part_type_create();
part_type_shape(water, pt_shape_sphere);
part_type_color2(water,c_aqua,c_ltgray);
part_type_orientation(water,0,0,0,15,1);
part_type_size(water,0,0.05,0,0);
part_type_speed(water,2,3,0,0);
part_type_direction(water,0,360,0,4);
part_type_life(water,7,11);
particle = water;

