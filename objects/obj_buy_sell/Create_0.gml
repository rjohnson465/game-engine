owner = global.owner;
items = owner.items;
global.isTrading = true;

global.owner = owner;
vendorItemsObj = instance_create_depth(x,y,1,obj_vendor_items);

global.owner = owner;
playerItemsObj = instance_create_depth(x,y,1,obj_player_items);