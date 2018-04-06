depth = -300;
ui = global.ui;
x1 = global.skillManager.healthMaxX;
y1 = global.skillManager.healthMaxY;
global.skillManager.skillSelector = id;

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
}

joystickInputFrame = 0;
joystickInputTotalFrames = 30;

selectedSkill = obj_skill_hpmax;