/// getItemFilterType(item)
/// @param item 
/// Return the InventoryFilter for a given item

var item = argument[0];

var itemType = noone; 
if item.type == ItemTypes.HandItem {
	if item.subType == HandItemTypes.Ranged {
		itemType = InventoryFilters.Ranged;
	} else {
		itemType = InventoryFilters.Melee;
	}
}
else if item.type == ItemTypes.Other {
	itemType = InventoryFilters.Other;
}
else if item.type == ItemTypes.Ring {
	itemType = InventoryFilters.Rings;
}
else if item.type == ItemTypes.Head {
	itemType = InventoryFilters.Head;
}

return itemType;