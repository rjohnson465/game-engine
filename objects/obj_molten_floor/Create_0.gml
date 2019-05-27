//event_inherited();
neverDeactivate = true;
isObstacleLayerless = false;
origLayer = layer;
postX = x;
postY = y;
isWall = true;

stopsAttacks = false;

alarm[7] = 5; // damage combatant every 5 frames

damages = ds_map_create();
ds_map_replace(damages, FIRE, [10,10]);

lightScaleX = image_xscale / 2;
lightScaleY = image_yscale / 2;
scale = 1;
scaleFrame = 0;
scaleTotalFrames = 120;

light_create_layer_multiscale(spr_light_square, lightScaleX, lightScaleY, C_FIRELIGHT, .95, 0, true);

douser = noone; // if a pipe is dousing the flame, its "douser"
isActive = true;

origXScale = image_xscale;
origYScale = image_yscale;

partSmoke = part_type_create();
system = part_system_create();
part_system_depth(system, layer_get_depth(origLayer));
emitter = part_emitter_create(system);
part_emitter_region(system, emitter, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_rectangle, ps_distr_gaussian);

smokeSteps = 10;
alarm[0] = smokeSteps;
part_type_shape(partSmoke, pt_shape_smoke);
part_type_alpha2(partSmoke,.6,0);
part_type_color2(partSmoke,c_dkgray,c_white);
part_type_orientation(partSmoke,0,360,.1,0,1);
part_type_size(partSmoke,0.2,0.3,.01,0);
part_type_speed(partSmoke,.1,.25,0,0);
part_type_direction(partSmoke,0,360,0,0);
part_type_life(partSmoke,45,90);

partSmoke2 = part_type_create();
part_type_shape(partSmoke2, pt_shape_smoke);
part_type_alpha2(partSmoke2,.6,0);
part_type_color2(partSmoke2,c_dkgray,c_white);
part_type_orientation(partSmoke2,0,360,-.1,0,0);
part_type_size(partSmoke2,0.2,0.3,.01,0);
part_type_speed(partSmoke2,.1,.25,0,0);
part_type_direction(partSmoke2,0,360,0,0);
part_type_life(partSmoke2,45,90);

var cinder = part_type_create();
part_type_shape(cinder,pt_shape_flare);
part_type_size(cinder,0,.1,0,0);
part_type_color2(cinder,c_orange,c_red);
part_type_alpha3(cinder,1,1,0); 
part_type_speed(cinder,.2,1,0,0);
part_type_direction(cinder,0,359,0,0);
part_type_blend(cinder,1);
part_type_life(cinder,25,50);
partCinder = cinder;

isCoolingDown = false;

/*
repeat(5) {
	randomize();
	var rand = random_range(-1, 1);
	var pt = noone;
	if rand > 0 {
		pt = partSmoke;
	}
	else {
		pt = partSmoke2;
	}
	part_emitter_burst(system, emitter, pt, 1);
}