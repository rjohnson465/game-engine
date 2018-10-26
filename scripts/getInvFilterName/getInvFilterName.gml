/// getInvFilterName(enum)
/// @param enum

var filter = argument[0];
var filterString = "";

switch filter {
	case InventoryFilters.Melee: {
		filterString = "Melee";
		break;
	}
	case InventoryFilters.Ranged: {
		filterString = "Ranged";
		break;
	}
	case InventoryFilters.Shields: {
		filterString = "Shields";
		break;
	}
	case InventoryFilters.Rings: {
		filterString = "Rings";
		break;
	}
	case InventoryFilters.Head: {
		filterString = "Hats";
		break;
	}
	case InventoryFilters.Other: {
		filterString = "Misc.";
		break;
	}
	case InventoryFilters.None: {
		filterString = "All";
		break;
	}
}

return filterString;