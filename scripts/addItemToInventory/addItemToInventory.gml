/// addItemToInventory(item)
/// returns false if the item cannot be added
/// @param item

var item = argument0;
var p = global.player;

if item == noone || item == undefined || !instance_exists(item) exit;

item.owner = p;

// itemType is either Ranged, Melee, Ring, Head, Other
var itemType = getItemFilterType(item);
var currentItemTypeCount = ds_map_find_value(global.player.inventoryCapacityMap, itemType);

if item.isStackable {
	// check if there's another item of this object_index in inventory
	var stack = noone;
	for (var i = 0; i < ds_list_size(p.inventory); i++) {
		var el = ds_list_find_value(p.inventory,i);
		if object_is_ancestor(el.object_index,obj_gem_parent) || object_is_ancestor(el.object_index, obj_gempieces_parent) {
			if el.object_index == item.object_index && el.condition == item.condition {
				stack = el;
			}
		}
		else if el.object_index == item.object_index {
			stack = el;
		}
	}
	// just increment the stack
	if stack != noone {
		stack.count += item.count;
		if item != undefined && item >= 0 && instance_exists(item) {
			instance_destroy(item, 1);
		}
	}
	// no stack exists, add the item to inv
	else {
		if (item.object_index != obj_item_coins) {
			
			// make sure we're not at capacity
			if (currentItemTypeCount < global.player.INVENTORY_MAX_CAPACITY) {
				ds_map_replace(global.player.inventoryCapacityMap, itemType, currentItemTypeCount + 1);
			} else {
				var fs = getInvFilterName(itemType);
				alert("You are at capacity for " + fs + " items!", c_red);
				return false;
				exit;
			}
		}
		ds_list_add(p.inventory,item);
		if !item.persistent {
			item.persistent = true;
		}
	}
}
// item is not stackable
else {
	if (currentItemTypeCount < global.player.INVENTORY_MAX_CAPACITY) {
		ds_map_replace(global.player.inventoryCapacityMap, itemType, currentItemTypeCount + 1);
	} else {
		var fs = getInvFilterName(itemType);
		alert("You are at capacity for " + fs + " items!", c_red);
		return false;
		exit;
	}
	ds_list_add(p.inventory,item);
	if !item.persistent {
		item.persistent = true;
	}
	// make sure all socketed gems belong to the player now too
	if ds_list_size(item.socketedGems) > 0 {
		for (var i = 0; i < ds_list_size(item.socketedGems); i++) {
			var gem = ds_list_find_value(item.socketedGems, i);
			gem.owner = global.player;
		}
	}
}

if !instance_exists(item) {
	return true;
	exit;
}

// some checks for "firsts" tutorial messages
var ck = ds_map_find_first(p.tutorialFirstsMap);
for (var i = 0; i < TutFirsts.length; i++) {
	
	var val = ds_map_find_value(p.tutorialFirstsMap, ck); // true or false
	if !val {
		var msg = ""; var spritesController = []; var spritesMk = []; var spritesSeps = [];
		switch ck {
			case TutFirsts.Gems: {
				if !object_is_ancestor(item.object_index, obj_gem_parent) break;
				msg = "Gems can be put into socketed items to enhance various item stats. Insert or remove gems from items at fountains.";
				break;
			}
			case TutFirsts.TwoHandedRangedWeapons: {
				if !item.isTwoHanded || !item.isRanged break;
				spritesController = [spr_prompt_xbox_rb, spr_prompt_xbox_lb];
				spritesMk = [spr_prompt_mk_rb, spr_prompt_mk_lb];
				spritesSeps = ["(hold) +"];
				msg = "Ready two handed ranged weapon, then fire. A fully charged weapon delivers the most damage.";
				break;
			}
			case TutFirsts.Shields: {
				if !object_is_ancestor(item.object_index, obj_shield_parent) break;
				spritesController = [spr_prompt_xbox_rb];
				spritesMk = [spr_prompt_mk_rb];
				msg = "Block (when shield is equipped). Shields absorb some (or all) of various damage types. Feel free to use one if you're a filthy casual.";
				break;
			}
			case TutFirsts.Hats: {
				if !object_is_ancestor(item.object_index, obj_hat_parent) break;
				msg = "Hats are primarily responsible for your defenses, and reduce incoming damage. Some are more stylish than others.";
				break;
			}
			case TutFirsts.Rings: {
				if item.type != ItemTypes.Ring break;
				msg = "Rings provide all sorts of statistical bonuses for your character. You can have four rings on at once, you diva.";
				break;
			}
		}
		if msg != "" {
			showTutorialMessage(msg,spritesController,spritesMk,ck);
			ds_map_replace(p.tutorialFirstsMap, ck, 1);
		}
	}
	
	ck = ds_map_find_next(p.tutorialFirstsMap, ck);
}

return true;

