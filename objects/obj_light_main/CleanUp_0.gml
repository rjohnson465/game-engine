ds_list_destroy(global._lights);
ds_list_destroy(global._light_casters);
surface_free(global._light_map);
surface_free(global._light_surface);
global._lights = -1;
global._light_casters = -1;
global._light_map = -1;
global._light_surface = -1;