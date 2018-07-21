/// applyBasePropertyModifiers(item)
/// iterate over an item's itemPropertyModifiers map and actually modify the items base props
/// this is called when loading an item that already has ites itemPropertyModifiers map saved OR
/// during item generation, after the itemPropertyModifiers map has been populated
/// @param item

var item = argument[0];
var props = item.itemPropertyModifiers;

if props == noone || !ds_exists(props, ds_type_map) || ds_map_size(props) == 0 exit;
if item.type == ItemTypes.Ring exit;

// iterate over item's itemPropertyModifiers, apply properties as needed
var currentProp = ds_map_find_first(props);
for (var i = 0; i < ds_map_size(props); i++) {
	var buff = ds_map_find_value(props, currentProp);
	
	switch item.type {
		case ItemTypes.HandItem: {
			// weapon
			if !object_is_ancestor(item.object_index, obj_shield_parent) {
				switch currentProp {
					case WeaponProperties.PhysicalDamageBonus: {
						modifyWeaponPhysicalDamage(item, buff);
						break;
					}
					case WeaponProperties.ElementalDamageBonus: {
						var element = buff[0];
						buff = buff[1];
						modifyWeaponElementalDamage(item, element, buff);
						break;
					}
					case WeaponProperties.ChargesBonus: {
						modifyWeaponCharges(item, buff);
						break;
					}
					case WeaponProperties.DurabilityAmmoBonus: {
						modifyWeaponDurabilityOrAmmo(item, buff);
					}
				}
				break;
			}
			
			// shield
			else {
				
				switch currentProp {
					case ShieldProperties.PhysicalBlockBonus: {
						modifyShieldPhysicalBlock(item, buff);
						break;
					}
					case ShieldProperties.ElementalBlockBonus: {
						var element = buff[0];
						buff = buff[1];
						modifyShieldElementalBlock(item, element, buff);
						break;
					}
					case ShieldProperties.DurabilityBonus: {
						modifyShieldDurability(item, buff);
						break;
					}
				}
				
				break;
			}
		}
		case ItemTypes.Head: {
			break;
		}
	}
	
	currentProp = ds_map_find_next(props, currentProp);
}

updateItemName(item);