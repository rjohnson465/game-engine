particle1 = global.enviroPart1;
particle2 = global.enviroPart2;
system1 = part_system_create();
system2 = part_system_create();

emitter1 = part_emitter_create(system1);
emitter2 = part_emitter_create(system2);
partDepth = global.enviroPartDepth;
partLayer = global.enviroPartLayer;

var partDrawDepth = layer_get_depth(partLayer) - 1000;
part_system_depth(system1, layer_get_depth(partLayer)-1000);
part_system_depth(system2, layer_get_depth(partLayer)-1000);

/*
part_system_depth(system1,partDepth);
part_system_depth(system2,partDepth);
*/
num1 = global.enviroPartNum1;
num2 = global.enviroPartNum2;
initNum1 = global.enviroPartInitNum1;
initNum2 = global.enviroPartInitNum2;


var pDepth = layer_get_depth(global.player.layer);

if pDepth == partDepth {
	var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
	if part_type_exists(particle1) {
		part_emitter_region(system1,emitter1,vx-1000,vx+2000,vy-2000,vy+2000,ps_shape_rectangle,ps_distr_linear); 
		part_emitter_stream(system1,emitter1,particle1,num1); 
		repeat(initNum1) {
			// part_system_update(system1);
			part_emitter_burst(system1, emitter1, particle1, num1);
		} 
	}
	if part_type_exists(particle2) {
		part_emitter_region(system2,emitter2,vx-1000,vx+2000,vy-2000,vy+2000,ps_shape_rectangle,ps_distr_linear); 
		part_emitter_stream(system2,emitter2,particle2,num2); 
		repeat(initNum2) {
			part_emitter_burst(system2, emitter2, particle2, num2);
			// part_system_update(system2);
		} 
	}
}
