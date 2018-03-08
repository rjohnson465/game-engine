///get_ids_region(obj, x1, y1, x2, y2)
/// @param obj
/// @param x1
/// @param y1
/// @param x2
/// @param y2
var list, n;
n = 0;
//arr[0] = noone;
list = ds_list_create();
var objType = argument[0];
var objectName = object_get_name(objType.object_index);
with (argument[0]) {
   if (point_in_rectangle(x, y, argument[1], argument[2], argument[3], argument[4])) {
      //arr[n++] = id;
	  ds_list_add(list,id);
   }
}
return list;