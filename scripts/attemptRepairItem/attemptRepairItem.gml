/// attemptRepairItem()
/// must be called by instance of obj_fountain_gui_nameprice
audio_play_sound(snd_fountain_repair,1,0);
randomize();
var rand = random_range(0,100);
if rand <= odds {
	var itemsGui = instance_nearest(x,y,obj_fountain_gui_brokenitems);
	var item = itemsGui.selectedItem;

	alert(string(item.name) + " sucessfully repaired ",c_lime);

	item.durability = item.durabilityMax;
	
	spendGold(namedPrice);
				
	global.fountainGui.alarm[1] = 2;
				
	global.fountainGui.currentMenu = FOUNTAIN;
	//instance_destroy(obj_fountain_gui_gems,1);
	instance_destroy(obj_fountain_gui_brokenitems,1);
	instance_destroy(id,1);
				
} else {
	alert("Item repair failed. You lost " + string(namedPrice) + " gold",c_red);
	spendGold(namedPrice);
}