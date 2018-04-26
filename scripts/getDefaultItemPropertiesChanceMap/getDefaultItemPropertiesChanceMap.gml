/// getDefaultItemPropertiesChanceMap()

var map = ds_map_create();
// relative probabilities -- 1-10, 1 is least likely, 10 is most likely
for (var i = 0; i < ModifiableProperties.length; i++) {
	switch i {
		case ModifiableProperties.HpMax: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.HpRegen: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.CriticalsChance: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.CriticalsDamage: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.HpSteal: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.StaminaSteal: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.WeaponTypesDamage: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.PhysicalDamageTypesMultiplier: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.ElementalDamageTypesMultiplier: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.Poise: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.XpMultiplier: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.Defenses: {
			ds_map_replace(map,i,5); break;
		}
		case ModifiableProperties.OffHandDamage: {
			ds_map_replace(map,i,5); break;
		}
	}
}

return map;