/// getDefaultItemTypeChanceMap()

var map = ds_map_create();
ds_map_replace(map,ItemTypes.HandItem,[50,100]);
ds_map_replace(map,ItemTypes.Head,[25,50]);
ds_map_replace(map,ItemTypes.Ring,[10,25]);
ds_map_replace(map,ItemTypes.Other,[0,10]);

return map;