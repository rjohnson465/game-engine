/// getItemPropertyValueRangeByActAndRarity(prop,act,rarity)
/// @param prop
/// @param act
/// @param rarity

var prop = argument[0];
var act = argument[1];
var rarity = argument[2];

var tierRand = random_range(0,100);
var range = noone;

// value range varies -- from item act, rarity, and rolled tier

var a1Vals = ds_map_create();
ds_map_replace(a1Vals,
	ModifiableProperties.HpMax,
	[ [1,10], [5,15], [8,18], [12,22] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.HpRegen,
	[ [.05,.2], [.2,.5], [.5,.7], [.7,1] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.StaminaMax,
	[ [1,10], [5,15], [8,18], [12,22] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.StaminaRegen,
	[ [.05,.2], [.2,.5], [.5,.7], [.7,1] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.WeaponTypesDamage,
	[ [1,3], [2,4], [3,7], [5,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.CriticalsChance,
	[ [1,5], [3,8], [5,10], [8,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.CriticalsDamage,
	[ [1,5], [3,8], [5,10], [8,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.PhysicalDamageTypesMultiplier,
	[ [1,3], [2,4], [3,7], [5,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.ElementalDamageTypesMultiplier,
	[ [1,3], [2,4], [3,7], [5,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.Defenses,
	[ [1,3], [2,4], [3,7], [5,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.Poise,
	[ [1,3], [2,4], [3,7], [5,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.OffHandDamage,
	[ [1,5], [5,8], [8,10], [10,15] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.HpSteal,
	[ [1,5], [5,8], [8,10], [10,15] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.StaminaSteal,
	[ [1,5], [5,8], [8,10], [10,15] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.GoldDrop,
	[ [1,5], [5,8], [8,10], [10,15] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.XpMultiplier,
	[ [5,10], [10,15], [12,17], [15,20] ]);

var map = noone;
switch act {
	case 1: {
		map = a1Vals; break;
	}
}

var vals = ds_map_find_value(map,prop);
var val = vals[rarity];

ds_map_destroy(a1Vals);

return val;
				
/*
switch prop {
	
	case ModifiableProperties.HpMax: {
		switch act {
			case 1: {
				switch rarity {
					case ItemRarities.Normal: {
						// act 1 / tier 1
						if tierRand < 80 {
							return [1,10];
						}
						// act 1 / tier 2
						else {
							return [5,12];
						}
						break;
					}
					case ItemRarities.Fine: {
						// act 1 / tier 1
						if tierRand < 45 {	
							return [5,15];
						}
						// act 1 / tier 2
						else if tierRand < 90 {
							return [8,18];
						}
						// act 1 / tier 3
						else {
							return [10,20];
						}
						break;
					}
					case ItemRarities.Masterwork: {
						// act 1 / tier 1
						if tierRand < 5 {	
							return [8,18];
						}
						// act 1 / tier 2
						else if tierRand < 45 {
							return [10,20];
						}
						// act 1 / tier 3
						else if tierRand < 85 {
							return [10,22];
						}
						// act 1 / tier 4
						else {
							return [12,23];
						}
						break;
					}
					case ItemRarities.Legendary: {
						// act 1 / tier 1
						if tierRand < 0 {	
							return [8,18];
						}
						// act 1 / tier 2
						else if tierRand < 10 {
							return [12,20];
						}
						// act 1 / tier 3
						else if tierRand < 40 {
							return [15,22];
						}
						// act 1 / tier 4
						else {
							return [18,25];
						}
						break;
					}
				}
				
				break;
			} // end HpMax act 1
			case 2: {
			} // end HpMax act 2
			case 3: {
			} // end HpMax act 3
			case 4: {
			} // end HpMax act 4
		}
		break;
	} // end HpMax
	
	case ModifiableProperties.HpRegen: {
		switch act {
			case 1: {
				return [.1,1];
				break;
			}
		}
		break;
	} // end hpRegen
	case ModifiableProperties.CriticalsChance: {
		switch act {
			case 1: {
				return [2,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.CriticalsDamage: {
		switch act {
			case 1: {
				return [2,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.HpSteal: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.StaminaSteal: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.StaminaMax: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.StaminaRegen: {
		switch act {
			case 1: {
				return [.1,1];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.WeaponTypesDamage: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.PhysicalDamageTypesMultiplier: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.ElementalDamageTypesMultiplier: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.Poise: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.XpMultiplier: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.Defenses: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.OffHandDamage: {
		switch act {
			case 1: {
				return [10,20];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.GoldDrop: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
}

return range;