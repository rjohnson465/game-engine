particle1 = global.enviroPart1;
particle2 = global.enviroPart2;
system1 = part_system_create();
system2 = part_system_create();
emitter1 = part_emitter_create(system1);
emitter2 = part_emitter_create(system2);
part_system_depth(system1,global.enviroPartDepth);
part_system_depth(system2,global.enviroPartDepth);
var num1 = global.enviroPartNum1;
var num2 = global.enviroPartNum2;

var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
if part_type_exists(particle1) {
	part_emitter_region(system1,emitter1,vx-1000,vx+2000,vy-2000,vy+2000,ps_shape_rectangle,ps_distr_linear); 
	part_emitter_stream(system1,emitter1,particle1,num1); 
	repeat(50) {part_system_update(system1);} 
}
if part_type_exists(particle2) {
	part_emitter_region(system2,emitter2,vx-1000,vx+2000,vy-2000,vy+2000,ps_shape_rectangle,ps_distr_linear); 
	part_emitter_stream(system2,emitter2,particle2,num2); 
	repeat(50) {part_system_update(system2);} 
}

