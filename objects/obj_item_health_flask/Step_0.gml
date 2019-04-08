/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var p = global.player;
var pad = p.gamePadIndex;
var ui = global.ui;
var chargesCount = ds_map_find_value(customItemProperties, hfs_charges);
if chargesCount <= 0 {
	canUse = false;
} else {
	canUse = true;
}

if p.beltItems[p.currentBeltItemIndex] == id && !canUse && !ui.isShowingMenus && gamepad_button_check_pressed(pad, gp_face3) {
	alert("Health flask out of charges", c_red);
}


if isInUse {
	
	if chargesCount > 0 {
		var chargeAmount = ds_map_find_value(customItemProperties, hfs_charge_strength);
		global.player.hp += chargeAmount;
		if global.player.hp > global.player.maxHp {
			global.player.hp = global.player.maxHp;
		}
		chargesCount--;
		ds_map_replace(customItemProperties, hfs_charges, chargesCount);
		updateHealthFlaskDescription();
	}
	
	isInUse = false;
}



