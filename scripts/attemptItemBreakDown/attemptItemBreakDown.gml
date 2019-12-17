/// attemptItemBreakDown()
/// must be called by instance of obj_fountain_gui_nameprice

if getGoldCount() < namedPrice {
	alert("Not enough gold", c_red);
	exit;
}

var itemsGui = instance_nearest(x,y,obj_fountain_gui_gemmeditems);
var item = itemsGui.selectedItem;
/*
// first, make sure the number of free slots player has in Misc inventory category is 
// equal to or greater than the number of gems that would come from this breakdown
var miscCount = ds_map_find_value(global.player.inventoryCapacityMap, InventoryFilters.Other); 
var gemCount = ds_list_size(item.socketedGems);
if global.player.INVENTORY_MAX_CAPACITY - gemCount < miscCount {
	alert("Not enough inventory space to break down " + item.name, c_red);
	exit;	
} */

audio_play_sound(snd_fountain_repair,1,0);
randomize();
var rand = random_range(0,100);
if rand <= odds {
	

	alert(string(item.name) + " sucessfully broken down ",c_lime);

	removeGemsFromItem(item);

	spendGold(namedPrice);
	appraiseItem(item);
				
	// refresh item particles if equipped
	with obj_weapon {
		if owner == global.player {
			refreshParticles = true;
		}
	}
				
	global.fountainGui.alarm[1] = 2;
				
	global.fountainGui.currentMenu = FOUNTAIN;
	instance_destroy(obj_fountain_gui_gems,1);
	instance_destroy(obj_fountain_gui_gemmeditems,1);
	instance_destroy(id,1);
				
} else {
	alert("Item break down failed. You lost " + string(namedPrice) + " gold",c_red);
	spendGold(namedPrice);
}