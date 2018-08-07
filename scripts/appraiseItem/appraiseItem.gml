/// appraiseItem(item)
/// @param item
/// how much is this item worth? Sets the "value" property of an item

var item = argument[0];

var value = 0;

if item.type == ItemTypes.Ring {
	value = appraiseRing(item);
} else {
	value = item.baseValue;
	// first, look at the "pts" stored in the itemPropertyModifiers map -- each pt is worth 100 gold?
	var pts = 0;
	var ck = ds_map_find_first(item.itemPropertyModifiers);
	for (var i = 0; i < ds_map_size(item.itemPropertyModifiers); i++) {
		var buff = ds_map_find_value(item.itemPropertyModifiers, ck);
		if is_array(buff) buff = buff[1];
		pts += buff;
		ck = ds_map_find_next(item.itemPropertyModifiers, ck);
	}
	value += pts*100;	
	
	// then factor in number of sockets (500 / socket?)
	value += item.numberOfSockets*500;
	
	// then factor in gems
	for (var i = 0; i < ds_list_size(item.socketedGems); i++) {
		var gem = ds_list_find_value(item.socketedGems, i);
		switch gem.condition {
			case CRACKED: {
				value += 1000; break;
			}
			case NORMAL: {
				value += 5000; break;
			}
			case EXQUISITE: {
				value += 10000; break;
			}
			case FLAWLESS: {
				value += 30000; break;
			}
		}
	}
}

item.value = round(value);