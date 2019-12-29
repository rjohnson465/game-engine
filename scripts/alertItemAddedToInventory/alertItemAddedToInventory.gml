/// alertItemAddedToInventory(item, *length)
/// @param item
/// @param *length

var item = argument[0];
var length = 120;

global.item = item;
global.alertMessageLength = length;
instance_create_depth(x,y,1,obj_itemadded_alert);