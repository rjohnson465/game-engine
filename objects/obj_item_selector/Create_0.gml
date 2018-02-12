depth = -300;
ui = global.ui;
x1 = global.inventory.invTopLeftX;
y1 = global.inventory.invTopLeftY;

slotWidth = global.inventory.slotWidth;
slotHeight = global.inventory.slotHeight;

inv = global.inventory;
eq = global.equippedItemsManager;

type = global.selectorType;

isActive = false;
if type == SelectorTypes.Select {
	isActive = true;
}

color = noone;
switch type {
	case SelectorTypes.Select: {
		color = c_black;
		break;
	}
	case SelectorTypes.Equip: {
		color = c_green;
		break;
	}
	case SelectorTypes.Imbue: {
		color = c_aqua;
	}
}