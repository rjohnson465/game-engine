// this should delete submaps (since theyre added with ds_map_add_map) 
// but you should check this to avoid mem leak
ds_map_destroy(persistentElements); persistentElements = -1;
ds_map_destroy(enemiesData); enemiesData = -1;