var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
part_emitter_region(system1,emitter1,vx-1000,vx+2000,vy-2000,vy+2000,ps_shape_rectangle,ps_distr_linear); 
part_emitter_region(system2,emitter2,vx-1000,vx+2000,vy-2000,vy+2000,ps_shape_rectangle,ps_distr_linear); 