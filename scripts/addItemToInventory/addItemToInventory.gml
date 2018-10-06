/// addItemToInventory(item)
/// @param item

var item = argument0;
var p = global.player;

if item == noone || item == undefined || !instance_exists(item) exit;

item.owner = p;

if item.isStackable {
	// check if there's another item of this object_index in inventory
	var stack = noone;
	for (var i = 0; i < ds_list_size(p.inventory); i++) {
		var el = ds_list_find_value(p.inventory,i);
		if object_is_ancestor(el.object_index,obj_gem_parent) {
			if el.object_index == item.object_index && el.condition == item.condition {
				stack = el;
			}
		}
		else if el.object_index == item.object_index {
			stack = el;
		}
	}
	if stack != noone {
		stack.count += item.count;
		instance_destroy(item,true);
	} else {
		ds_list_add(p.inventory,item);
		if !item.persistent {
			item.persistent = true;
		}
	}
} else {
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

if !instance_exists(item) exit;

// some checks for "firsts" tutorial messages
var ck = ds_map_find_first(p.tutorialFirstsMap);
for (var i = 0; i < TutFirsts.length; i++) {
	
	var val = ds_map_find_value(p.tutorialFirstsMap, ck); // true or false
	if !val {
		var msg = ""; var spritesController = []; var spritesMk = [];
		switch ck {
			case TutFirsts.TwoHandedRangedWeapons: {
				if !item.isTwoHanded || !item.isRanged break;
				spritesController = [spr_prompt_xbox_rb, spr_prompt_xbox_lb];
				spritesMk = [spr_prompt_mk_rb, spr_prompt_mk_lb];
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
		}
	}
	
	ck = ds_map_find_next(p.tutorialFirstsMap, ck);
}



