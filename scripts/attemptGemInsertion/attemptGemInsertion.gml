/// attemptGemInsertion()
/// must be called by instance of obj_fountain_gui_nameprice
randomize();
var rand = random_range(0,100);
if rand <= odds {
	var itemsGui = instance_nearest(x,y,obj_fountain_gui_socketeditems);
	var item = itemsGui.selectedItem;
	var gemGui = instance_nearest(x,y,obj_fountain_gui_gems);
	var gem = gemGui.selectedItem;
	alert(string(gem.name)+ " sucessfully inserted into " + string(item.name),c_lime);
	spendGold(namedPrice);
	insertGemIntoItem(gem,item);
				
	// refresh item if equipped
	with obj_weapon {
		if owner == global.player {
			refreshParticles = true;
		}
	}
				
	global.fountainGui.currentMenu = FOUNTAIN;
	instance_destroy(obj_fountain_gui_gems,1);
	instance_destroy(obj_fountain_gui_socketeditems,1);
	instance_destroy(id,1);
				
} else {
	alert("Gem insertion failed. You lost " + string(namedPrice) + " gold",c_red);
	spendGold(namedPrice);
}