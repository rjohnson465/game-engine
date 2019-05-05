/// buyItem(item)
/// @param item
/// called by an instance of obj_vendor_items

var item = argument[0];

var gp = getGoldCount();
var p = global.player;

// also make sure you don't already have too many items of that type
var alreadyHasStackableItem = false;
if item.isStackable {
	// do we already have an item of this type
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
		alreadyHasStackableItem = true;
	}
}

var itemType = getItemFilterType(item);
var currentItemTypeCount = ds_map_find_value(p.inventoryCapacityMap, itemType);
if !alreadyHasStackableItem && currentItemTypeCount >= p.INVENTORY_MAX_CAPACITY {
	var fs = getInvFilterName(itemType);
	alert("You are at capacity for " + fs + " items!", c_red);
	exit;
}

// ok, we can go through with the purchase
if gp >= item.value {
	audio_play_sound(snd_item_coins,1,0);
	alert("Purchased " + item.name + " for " + string(item.value) + " gold",c_yellow);
	spendGold(item.value);
	var oldCount = item.count;
	
	// remove this item from npcData.inventory
	var npc = obj_vendor_items.owner;
	var index = ds_list_find_index(npc.npcData.inventory, item);
	ds_list_delete(npc.npcData.inventory, index);
	
	if item.isStackable {
		var item2 = instance_create_depth(x,y,1,item.object_index);
		item2.count = 1;
		addItemToInventory(item2);
	} else {
		addItemToInventory(item);
	}
	if !item.isStackable || (item.isStackable && item.count == 1) {
		var pos = ds_list_find_index(items,item);
		ds_list_delete(items,pos);
		if (item.isStackable && item.count == 1) {
			if item != undefined && item >= 0 && instance_exists(item) {
				instance_destroy(item, 1); item = -1;
			}
		}
	} else {
		item.count = oldCount;
		item.count--;
	}
	var maybeNextSelectedItem = ds_list_find_value(inv,0);
	if maybeNextSelectedItem != noone && maybeNextSelectedItem != undefined && instance_exists(maybeNextSelectedItem) {
		selectedItem = maybeNextSelectedItem;
	} else {
		selectedItem = noone;
	}
} else {
	alert("You do not have enough gold", c_red);
}
isConfirming = false;
isAcceptingConfirmInput = false;