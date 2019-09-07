// Inherit the parent event
event_inherited();

material = ICE_MAT;

// depth += 1; // hands appear over flower
stopsAttacks = true;

isActive = false;

index = image_index;

startSprite = spr_ww_icecrystals_start;
endSprite = spr_ww_icecrystals_end;
midSprite = spr_ww_icecrystals_mid;

soundIndex = noone;


system = part_system_create();
part_system_depth(system, layer_get_depth(origLayer));
part_system_depth(system, depth-5);

emitter = part_emitter_create(system);
part_emitter_region(system, emitter, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_rectangle, ps_distr_gaussian);

partSmoke = part_type_create();
part_type_shape(partSmoke, pt_shape_smoke);
part_type_alpha2(partSmoke,.3,0);
part_type_color2(partSmoke,c_purple,c_aqua);
part_type_orientation(partSmoke,0,360,.1,0,1);
part_type_size(partSmoke,0.5,0.7,.01,0);
part_type_speed(partSmoke,.1,.25,0,0);
part_type_direction(partSmoke,0,360,0,0);
part_type_life(partSmoke,120,200);

partSmoke2 = part_type_create();
part_type_shape(partSmoke2, pt_shape_smoke);
part_type_alpha2(partSmoke2,.3,0);
part_type_color2(partSmoke2,c_purple,c_aqua);
part_type_orientation(partSmoke2,0,360,-.1,0,0);
part_type_size(partSmoke2,0.5,0.7,.01,0);
part_type_speed(partSmoke2,.1,.25,0,0);
part_type_direction(partSmoke2,0,360,0,0);
part_type_life(partSmoke,120,200);


