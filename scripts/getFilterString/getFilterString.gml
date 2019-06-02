/// getItemFilterString(filter)
/// @param filter enum value

var filter = argument[0];

var str = "";
switch filter {
	case InventoryFilters.Head: {
		str = "Hats"; break;
	}
	case InventoryFilters.Melee: {
		str = "Melee Items"; break;
	}
	case InventoryFilters.Ranged: {
		str = "Ranged Items"; break;
	}
	case InventoryFilters.Other: {
		str = "Miscellaneous Items"; break;
	}
	case InventoryFilters.Keys: {
		str = "Keys"; break;
	}
	case InventoryFilters.Gems: {
		str = "Gems"; break;
	}
	case InventoryFilters.Rings: {
		str = "Rings"; break;
	}
}

return str;