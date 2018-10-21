/// damageItem(item,amount)
/// @param item
/// @param amount

var item = argument[0];
var amount = argument[1];

item.durability -= amount;

// if below 33% durability, alert
if (item.durability/item.durabilityMax) < .33 && item.durability > 0 && !item.hasIssuedDurabilityWarning {
	alert(item.name + " at risk!",c_yellow);
	item.hasIssuedDurabilityWarning = true;
}

if item.durability <= 0 && !item.hasIssuedDurabilityObituary {
	alert(item.name + " broke!",c_red);
	audio_play_sound(snd_shield_hit_metal,1,0);
	item.hasIssuedDurabilityObituary = true;
	
	// if this is the first time an item has broken in this game, give tutorial on item repair
	if ds_map_find_value(global.player.tutorialFirstsMap, TutFirsts.BrokenItems) == false {
		//ds_map_replace(global.player.tutorialFirstsMap, TutFirsts.BrokenItems, true);
		var msg = "Weapons and shields lose durability with use. Durability is refilled when wishing at a fountain. If an item breaks, a generous wish must be made to fix it...";
		showTutorialMessage(msg, [], [], TutFirsts.BrokenItems);
	}
}