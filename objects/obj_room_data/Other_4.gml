/*if room != roomIndex {
	// make itemDrops (persistent) not appear on screen at all 
	for (var i = 0; i < ds_list_size(itemDropsData); i++) {
		var itemDropDataObj = ds_list_find_value(itemDropsData,i);
		var itemDrop = findPersistentRoomElement(obj_item_drop,itemDropDataObj.postX,itemDropDataObj.postY);
		
		if itemDrop {
			itemDrop.x = -1000;
			itemDrop.y = -1000;
		} else {
			ds_list_delete(itemDropsData,i);
		}
	}
}