/// makeConfettiParticle(color)
/// @param color
var color = argument[0];
/*
var part = part_type_create();
part_type_sprite(part,spr_particle_fire,0,0,1);
part_type_alpha2(part,.8,.2);
part_type_orientation(part,0,0,0,15,1);
part_type_size(part,0,0.5,0,0);
part_type_speed(part,5,6,0,0);
part_type_direction(part,0,360,0,4);
part_type_life(part,15,20);
part_type_color1(part,color);
*/
var fire = part_type_create();
part_type_sprite(fire,spr_particle_confetti,0,0,1);
part_type_size(fire,0,.3,0,0);
part_type_color1(fire,color);
part_type_alpha3(fire,.8,.5,.2);
part_type_speed(fire,5,6,0,0);
part_type_direction(fire,0,360,0,4);
part_type_orientation(fire,0,0,0,15,1);
part_type_blend(fire,1);
part_type_life(fire,15,20);

return fire;