/// addItemProperty(item, property, value)
/// @param item
/// @param property
/// @param value

var item = argument[0];
var prop = argument[1];
var val = argument[2];

ds_map_replace(item.itemProperties,prop,val);
updateItemName(item);