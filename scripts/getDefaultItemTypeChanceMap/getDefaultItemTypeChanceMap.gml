/// getDefaultItemTypeChanceMap()

var map = ds_map_create();
ds_map_replace(map,ItemTypes.HandItem,[-1,-1]);
ds_map_replace(map,ItemTypes.Head,[-1,-1]);
ds_map_replace(map,ItemTypes.Ring,[0,100]);
ds_map_replace(map,ItemTypes.Other,[0,10]);

return map;