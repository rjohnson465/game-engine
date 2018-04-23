/// getDefaultItemTypeChanceMap()

var map = ds_map_create();

// always drop ring test case

ds_map_replace(map,ItemTypes.HandItem,[-1,0]);
ds_map_replace(map,ItemTypes.Head,[-1,0]);
ds_map_replace(map,ItemTypes.Ring,[0,100]);
ds_map_replace(map,ItemTypes.Other,[-1,0]);


// normal case
/*
ds_map_replace(map,ItemTypes.HandItem,[0,60]);
ds_map_replace(map,ItemTypes.Head,[60,80]);
ds_map_replace(map,ItemTypes.Ring,[80,95]);
ds_map_replace(map,ItemTypes.Other,[95,100]);
*/

return map;