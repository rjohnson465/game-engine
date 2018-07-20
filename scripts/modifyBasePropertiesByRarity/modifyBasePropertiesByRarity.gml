/// modifyBasePropertiesByRarity(item, rarity)
/// @param item
/// @param rarity

var item = argument[0];
var rarity = argument[1];

if rarity == ItemRarities.Normal show_debug_message("REFEF");
if item.rarity = ItemRarities.Normal show_debug_message("REE");

if item.rarity == ItemRarities.Normal exit;
if item.type == ItemTypes.Ring exit;

// calculate total "points" to spend on buffing the item; this is based on rarity
var pts = 0;
var arr = global.basePropModTiers; // as defined in obj_item_parent

randomize();
switch rarity {
	case ItemRarities.Fine: {
		pts = round(random_range(arr[0], arr[1]));
		break;
	}
	case ItemRarities.Masterwork: {
		pts = round(random_range(arr[2], arr[3]));
		break;
	}
	case ItemRarities.Legendary: {
		pts = round(random_range(arr[4], arr[5]));
		break;
	}
}

// populate the item's itemPropertyModifers map
switch item.type {
	case ItemTypes.HandItem: {
		// handle shield prop buffing differently than weapons
		if object_is_ancestor(item.object_index, obj_shield_parent) {
		}
		// handle weapon prop buffing differently than shields
		else {
			modifyBasePropertiesWeapon(item,rarity,pts);
		}
		break;
	}
	case ItemTypes.Head: {
		// handle hat prop buffing
		
		break;
	}
}

// actually apply the modifications specified by the itemPropertyModifers map
applyBasePropertyModifiers(item);
