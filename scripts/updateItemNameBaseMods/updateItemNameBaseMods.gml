/// updatetemNameBaseMods(item)
/// @param item

var item = argument[0];
item.baseNameModified = item.baseName;

var props = item.itemPropertyModifiers;

if props == noone || !ds_exists(props, ds_type_map) || ds_map_size(props) == 0 exit;

// prefixes and suffixes
var p1 = ""; var p2 = ""; var s1 = ""; var s2 = "";
// tier cutoffs
var t1 = 15; var t2 = 25; var t3 = 45; var t4 = 65;
var currentProp = ds_map_find_first(props);

for (var i = 0; i < ds_map_size(props); i++) {
	var buff = ds_map_find_value(props, currentProp);
	
	switch item.type {
		case ItemTypes.HandItem: {
			// shield
			if object_is_ancestor(item.object_index, obj_shield_parent) {
				switch currentProp {
					case ShieldProperties.PhysicalBlockBonus: {
						if buff < t1 {
							p1 = "Thick";
						}
						else if buff > t1 && buff < t2 {
							p1 = "Sturdy";
						}
						else if buff > t2 && buff < t3 {
							p1 = "Impervious";
						}
						else if buff > t3 {
							p1 = "Impenetrable";
						}
						break;
					}
					case ShieldProperties.ElementalBlockBonus: {
						var element = buff[0];
						buff = buff[1];
						switch element {
							case MAGIC: {
								if buff < t1 {
									p2 = "Charmed";
								}
								else if buff > t1 && buff < t2 {
									p2 = "Magical";
								}
								else if buff > t2 && buff < t3 {
									p2 = "Spellbound";
								}
								else if buff > t3 {
									p2 = "Mythical";
								}
								break;
							}
							case FIRE: {
								if buff < t1 {
									p2 = "Igneous";
								}
								else if buff > t1 && buff < t2 {
									p2 = "Forged";
								}
								else if buff > t2 && buff < t3 {
									p2 = "Smelted";
								}
								else if buff > t3 {
									p2 = "Molten";
								}
								break;
							}
							case ICE: {
								if buff < t1 {
									p2 = "Cold";
								}
								else if buff > t1 && buff < t2 {
									p2 = "Snowy";
								}
								else if buff > t2 && buff < t3 {
									p2 = "Icy";
								}
								else if buff > t3 {
									p2 = "Freezing";
								}
								break;
							}
							case POISON: {
								if buff < t1 {
									p2 = "Noxious";
								}
								else if buff > t1 && buff < t2 {
									p2 = "Rotting";
								}
								else if buff > t2 && buff < t3 {
									p2 = "Vile";
								}
								else if buff > t3 {
									p2 = "Putrid";
								}
								break;
							}
							case LIGHTNING: {
								if buff < t1 {
									p2 = "Crackling";
								}
								else if buff > t1 && buff < t2 {
									p2 = "Shocking";
								}
								else if buff > t2 && buff < t3 {
									p2 = "Jolting";
								}
								else if buff > t3 {
									p2 = "Frying";
								}
								break;
							}
						}
						break;
					}
					case ShieldProperties.DurabilityBonus: {
						if buff < t1 {
							s1 = "Durable";
						}
						else if buff > t1 && buff < t2 {
							s1 = "Braced";
						}
						else if buff > t2 && buff < t3 {
							s1 = "Enforced";
						}
						else if buff > t3 {
							s1 = "Indestructible";
						}
						break;
					}
				}
				
				break;	
			} 
			// weapon 
			else {
				switch currentProp {
					case WeaponProperties.PhysicalDamageBonus: {
						if buff < t1 {
							p1 = "Fine";
						}
						else if buff > t1 && buff < t2 {
							p1 = "Polished";
						}
						else if buff > t2 && buff < t3 {
							p1 = "Gleaming";
						}
						else if buff > t3 {
							p1 = "Lethal";
						}
						break;
					}
					case WeaponProperties.ElementalDamageBonus: {
						var element = buff[0];
						buff = buff[1];
						switch element {
							case MAGIC: {
								if buff < t1 {
									p2 = "Charmed";
								}
								else if buff > t1 && buff < t2 {
									p2 = "Magical";
								}
								else if buff > t2 && buff < t3 {
									p2 = "Spellbound";
								}
								else if buff > t3 {
									p2 = "Mythical";
								}
								break;
							}
							case FIRE: {
								if buff < t1 {
									p2 = "Igneous";
								}
								else if buff > t1 && buff < t2 {
									p2 = "Forged";
								}
								else if buff > t2 && buff < t3 {
									p2 = "Smelted";
								}
								else if buff > t3 {
									p2 = "Molten";
								}
								break;
							}
							case ICE: {
								if buff < t1 {
									p2 = "Cold";
								}
								else if buff > t1 && buff < t2 {
									p2 = "Snowy";
								}
								else if buff > t2 && buff < t3 {
									p2 = "Icy";
								}
								else if buff > t3 {
									p2 = "Freezing";
								}
								break;
							}
							case POISON: {
								if buff < t1 {
									p2 = "Noxious";
								}
								else if buff > t1 && buff < t2 {
									p2 = "Rotting";
								}
								else if buff > t2 && buff < t3 {
									p2 = "Vile";
								}
								else if buff > t3 {
									p2 = "Putrid";
								}
								break;
							}
							case LIGHTNING: {
								if buff < t1 {
									p2 = "Crackling";
								}
								else if buff > t1 && buff < t2 {
									p2 = "Shocking";
								}
								else if buff > t2 && buff < t3 {
									p2 = "Jolting";
								}
								else if buff > t3 {
									p2 = "Frying";
								}
								break;
							}
						}
						break;
					}
					case WeaponProperties.DurabilityAmmoBonus: {
						if item.isRanged {
							if buff < t1 {
								s1 = "Able";
							}
							else if buff > t1 && buff < t2 {
								s1 = "Prepared";
							}
							else if buff > t2 && buff < t3 {
								s1 = "Primed";
							}
							else if buff > t3 {
								s1 = "Unlimited";
							}
						} else {
							if buff < t1 {
								s1 = "Durable";
							}
							else if buff > t1 && buff < t2 {
								s1 = "Braced";
							}
							else if buff > t2 && buff < t3 {
								s1 = "Enforced";
							}
							else if buff > t3 {
								s1 = "Indestructible";
							}
						}
						break;
					}
					case WeaponProperties.ChargesBonus: {
						if buff < t1 {
							s2 = "Sorceror";
						}
						else if buff > t1 && buff < t2 {
							s2 = "Wizard";
						}
						else if buff > t2 && buff < t3 {
							s2 = "Warlock";
						}
						else if buff > t3 {
							s2 = "Magi";
						}
						break;
					}
				}
				break;
			}
		}
		case ItemTypes.Head: {
			
			if currentProp != HatProperties.ElementalDefenseBonus {
			
				// which physical defense buff, if any, is greatest?
				var greatestType = noone;
				var slashBonus = ds_map_find_value(item.itemPropertyModifiers, HatProperties.SlashDefenseBonus);
				var crushBonus = ds_map_find_value(item.itemPropertyModifiers, HatProperties.CrushDefenseBonus);
				var pierceBonus = ds_map_find_value(item.itemPropertyModifiers, HatProperties.PierceDefenseBonus);
				if slashBonus == undefined slashBonus = 0;
				if pierceBonus == undefined pierceBonus = 0;
				if crushBonus == undefined crushBonus = 0;
				if slashBonus >= crushBonus && slashBonus >= pierceBonus greatestType = SLASH;
				else if crushBonus >= slashBonus && crushBonus >= pierceBonus greatestType = CRUSH;
				else if pierceBonus >= slashBonus && pierceBonus >= crushBonus greatestType = PIERCE;
			
				switch greatestType {
					case SLASH: {
						if buff < t1 {
							p1 = "Squire's";
						}
						else if buff > t1 && buff < t2 {
							p1 = "Knight's";
						}
						else if buff > t2 && buff < t3 {
							p1 = "Lord's";
						}
						else if buff > t3 {
							p1 = "Warlock's";
						}
						break;
					}
					case CRUSH: {
						if buff < t1 {
							p1 = "Savage's";
						}
						else if buff > t1 && buff < t2 {
							p1 = "Brute's";
						}
						else if buff > t2 && buff < t3 {
							p1 = "Ogre's";
						}
						else if buff > t3 {
							p1 = "Titan's";
						}
						break;
					}
					case PIERCE: {
						if buff < t1 {
							p1 = "Scoundrel's";
						}
						else if buff > t1 && buff < t2 {
							p1 = "Fencer's";
						}
						else if buff > t2 && buff < t3 {
							p1 = "Duelist's";
						}
						else if buff > t3 {
							p1 = "Blademaster's";
						}
						break;
					}
				}
			}
			// elemental resistance buff
			else {
				var element = buff[0];
				buff = buff[1];
				switch element {
					case MAGIC: {
						if buff < t1 {
							p2 = "Charmed";
						}
						else if buff > t1 && buff < t2 {
							p2 = "Magical";
						}
						else if buff > t2 && buff < t3 {
							p2 = "Spellbound";
						}
						else if buff > t3 {
							p2 = "Mythical";
						}
						break;
					}
					case FIRE: {
						if buff < t1 {
							p2 = "Igneous";
						}
						else if buff > t1 && buff < t2 {
							p2 = "Forged";
						}
						else if buff > t2 && buff < t3 {
							p2 = "Smelted";
						}
						else if buff > t3 {
							p2 = "Molten";
						}
						break;
					}
					case ICE: {
						if buff < t1 {
							p2 = "Cold";
						}
						else if buff > t1 && buff < t2 {
							p2 = "Snowy";
						}
						else if buff > t2 && buff < t3 {
							p2 = "Icy";
						}
						else if buff > t3 {
							p2 = "Freezing";
						}
						break;
					}
					case POISON: {
						if buff < t1 {
							p2 = "Noxious";
						}
						else if buff > t1 && buff < t2 {
							p2 = "Rotting";
						}
						else if buff > t2 && buff < t3 {
							p2 = "Vile";
						}
						else if buff > t3 {
							p2 = "Putrid";
						}
						break;
					}
					case LIGHTNING: {
						if buff < t1 {
							p2 = "Crackling";
						}
						else if buff > t1 && buff < t2 {
							p2 = "Shocking";
						}
						else if buff > t2 && buff < t3 {
							p2 = "Jolting";
						}
						else if buff > t3 {
							p2 = "Frying";
						}
						break;
					}
				}
			}
			
			break;
		}
	}
	
	currentProp = ds_map_find_next(props, currentProp);
}

// construct new name from prefixes and suffixes
var newName = "";
var mods = [p1, p2, s1, s2];
for (var i = 0; i < array_length_1d(mods); i++) {
	var m = mods[i];
	//if m != "" {
		if (i == 0 || i == 1) && m != "" {
			newName += m + " ";
		}
		if (i > 1 && (s1 != "" || s2 != "")) {
			if i == 2 newName += "of the ";
			if mods[i] != "" newName += mods[i] + " ";
		}
	//}	
	if (i == 1) newName += item.baseName + " ";
}

item.baseNameModified = newName;
item.name = newName;