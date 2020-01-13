/// appraiseItem(item)
/// @param item
/// how much is this item worth? Sets the "value" property of an item

var item = argument[0];

var value = 0;

if item.type == ItemTypes.Ring {
	value = appraiseRing(item);
} else {
	value = item.baseValue;
	/*// first, look at the "pts" stored in the itemPropertyModifiers map -- each pt is worth 100 gold?
	var pts = 0;
	var ck = ds_map_find_first(item.itemPropertyModifiers);
	for (var i = 0; i < ds_map_size(item.itemPropertyModifiers); i++) {
		var buff = ds_map_find_value(item.itemPropertyModifiers, ck);
		if is_array(buff) buff = buff[1];
		pts += buff;
		ck = ds_map_find_next(item.itemPropertyModifiers, ck);
	}
	value += pts*100;*/	
	var ck = ds_map_find_first(item.itemPropertyModifiers);
	for (var i = 0; i < ds_map_size(item.itemPropertyModifiers); i++) {
		var buff = ds_map_find_value(item.itemPropertyModifiers, ck);
		if is_array(buff) buff = buff[1];
		// weapon or shield
		if item.type == ItemTypes.HandItem {
			// shield
			if object_is_ancestor(item.object_index, obj_shield_parent) {
				switch ck {
					case ShieldProperties.DurabilityBonus: {
						// each durability point for a shield is worth 122 gold
						value += 122*buff;
						break;
					}
					case ShieldProperties.PhysicalBlockBonus: {
						// each physical block point for a shield is worth 98 gold
						value += 98*buff;
						break;
					}
					case ShieldProperties.ElementalBlockBonus: {
						// each elemental block point for a shield is worth 74 gold
						value += 74*buff;
						break;
					}
				}
			} 
			// weapon
			else {
				switch ck {
					case WeaponProperties.ChargesBonus: {
						// each magic charge is worth 56 gold
						value += 56*buff;
						break;
					}
					case WeaponProperties.DurabilityAmmoBonus: {
						// each point of durability or projectile is worth 144 gold
						value += 144*buff;
						break;
					}
					case WeaponProperties.ElementalDamageBonus: {
						// each point of elemental damamge is worth 311 gold
						var minDamageBuff = round((buff/6));
						var maxDamageBuff = round(minDamageBuff*1.5);
						if maxDamageBuff == 0 maxDamageBuff = 1;
						
						var totalElementalPointsAdded = minDamageBuff + maxDamageBuff;
						
						value += 311*totalElementalPointsAdded;
						break;
					}
					case WeaponProperties.PhysicalDamageBonus: {
						// each point of physical damage is worth 251 gold
						value += 251*buff;
						break;
					}
				}
			}
		}
		// hat
		else {
			if ck == HatProperties.ElementalDefenseBonus {
				// each point of elemental resistance is worth 298 gold 
				value += 298*buff;
			} else {
				// each point of physical defense (slash | pierce | crush) is worth 291 gold
				value += 291*buff;
			}
		}
		ck = ds_map_find_next(item.itemPropertyModifiers, ck);
	}
	
	// then factor in number of sockets (500 / socket?)
	value += item.numberOfSockets*500;
	
	// then factor in gems
	for (var i = 0; i < ds_list_size(item.socketedGems); i++) {
		var gem = ds_list_find_value(item.socketedGems, i);
		switch gem.condition {
			case CRACKED: {
				value += 1000; break;
			}
			case NORMAL: {
				value += 5000; break;
			}
			case EXQUISITE: {
				value += 10000; break;
			}
			case FLAWLESS: {
				value += 30000; break;
			}
		}
	}
}

item.value = round(value);