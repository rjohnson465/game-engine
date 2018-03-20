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
		color = c_white;
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

// for equip selector only -- set if moveSelector selects an item in inventory to equip
acceptableEquipmentSlots = [];

joystickInputFrame = 0;
joystickInputTotalFrames = 30;