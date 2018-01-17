/// @description isRoomDark(roomIndex)
/// @param roomIndex
var roomIndex = argument[0];

var roomDarknessMap = ds_map_create();
ds_map_replace(roomDarknessMap,0,true);

return ds_map_find_value(roomDarknessMap,roomIndex);