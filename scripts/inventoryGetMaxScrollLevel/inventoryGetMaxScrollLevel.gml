/// inventoryGetMaxScrollLevel

// at what scrollLevel does this obj display its final inv element

var sl = -1;

if ds_list_size(inv) == 0 {
	return 0;
}

var lastItem = ds_list_find_value(inv,ds_list_size(inv)-1);
var lastItemSeen = false;
while !lastItemSeen {
	sl++;
	// show 20 items at a time;
	for (var i = 0; i < 20; i++) {
		var index = i + (5*sl);
		var item = ds_list_find_value(inv,index);
		
		if item == lastItem {
			lastItemSeen = true;
			break;
		}
	}
}

return sl;