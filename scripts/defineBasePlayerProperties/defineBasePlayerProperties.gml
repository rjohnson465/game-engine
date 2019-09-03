/// defineBasePlayerProperties()
/// return map

var basePlayerProperties = ds_map_create();

for (var i = 0; i <= ModifiableProperties.length; i++) {
	
	// ds_map_replace(basePlayerProperties,i,0); // never have empty base property
	
	switch i {
		case ModifiableProperties.GoldDrop: {
			ds_map_replace(basePlayerProperties,i,100); break;
		}
		case ModifiableProperties.HpMax: {
			ds_map_replace(basePlayerProperties,i,100); break;
		}
		case ModifiableProperties.HpRegen: {
			ds_map_replace(basePlayerProperties,i,0); break;
		}
		case ModifiableProperties.StaminaMax: {
			ds_map_replace(basePlayerProperties,i,50); break;
		}
		case ModifiableProperties.XpMultiplier: {
			ds_map_replace(basePlayerProperties,i,100); break;
		}
		case ModifiableProperties.StaminaRegen: {
			ds_map_replace(basePlayerProperties,i,20); break;
		}
		case ModifiableProperties.OffHandDamage: {
			ds_map_replace(basePlayerProperties,i,50); break;
		}
		case ModifiableProperties.EquipmentLoad: {
			ds_map_replace(basePlayerProperties,i,50); break;
		}
		/*case ModifiableProperties.Poise: {
			ds_map_replace(basePlayerProperties,i,0); break;
		}*/
		case ModifiableProperties.PoiseMax: {
			ds_map_replace(basePlayerProperties,i,10); break;
		}
		case ModifiableProperties.HpSteal: {
			ds_map_replace(basePlayerProperties,i,0); break;
		}
		case ModifiableProperties.StaminaSteal: {
			ds_map_replace(basePlayerProperties,i,0); break;
		}
		case ModifiableProperties.Defenses: {
			// a map in a map wowee
			var defensesMap = ds_map_create();
			for (var j = 0; j < array_length_1d(global.ALL_DAMAGE_TYPES); j++) {
				var wt = global.ALL_DAMAGE_TYPES[j];
				ds_map_replace(defensesMap,wt,0);
			}
			// ds_map_replace(basePlayerProperties,i,defensesMap);
			ds_map_add_map(basePlayerProperties, i, defensesMap);
			break;
		}
		case ModifiableProperties.PhysicalDamageTypesMultiplier: {
			var physicalDamageTypes = [SLASH,CRUSH,PIERCE,PHYSICAL];
			var damagesMap = ds_map_create();
			for (var j = 0; j < array_length_1d(physicalDamageTypes); j++) {
				var dt = physicalDamageTypes[j];
				ds_map_replace(damagesMap,dt,100);
			}
			// ds_map_replace(basePlayerProperties,i,damagesMap);
			ds_map_add_map(basePlayerProperties, i, damagesMap);
			break;
		}
		case ModifiableProperties.ElementalDamageTypesMultiplier: {
			var damagesMap = ds_map_create();
			for (var j = 0; j < array_length_1d(global.ALL_ELEMENTS); j++) {
				var dt = global.ALL_ELEMENTS[j];
				ds_map_replace(damagesMap,dt,100);
			}
			//ds_map_replace(basePlayerProperties,i,damagesMap);
			ds_map_add_map(basePlayerProperties, i, damagesMap);
			break;
		}
		case ModifiableProperties.CriticalsChance: {
			// a map in a map wowee
			var criticalsChanceMap = ds_map_create();
			for (var j = 0; j < array_length_1d(global.ALL_WEAPON_TYPES); j++) {
				var wt = global.ALL_WEAPON_TYPES[j];
				ds_map_replace(criticalsChanceMap,wt,15); // default 15% chance of critical
			}
			// ds_map_replace(basePlayerProperties,i,criticalsChanceMap);
			ds_map_add_map(basePlayerProperties, i, criticalsChanceMap);
			//ds_map_destroy(criticalsChanceMap);
			break;
		}
		case ModifiableProperties.CriticalsDamage: {
			// a map in a map wowee
			var criticalsDamageMap = ds_map_create();
			for (var j = 0; j < array_length_1d(global.ALL_WEAPON_TYPES); j++) {
				var wt = global.ALL_WEAPON_TYPES[j];
				ds_map_replace(criticalsDamageMap,wt,50); // default +50% damage on criticals
			}
			// ds_map_replace(basePlayerProperties,i,criticalsDamageMap);
			ds_map_add_map(basePlayerProperties, i, criticalsDamageMap);
			//ds_map_destroy(criticalsDamageMap);
			break;
		}
		case ModifiableProperties.WeaponTypesDamage: {
			var weaponDamageMap = ds_map_create();
			for (var j = 0; j < array_length_1d(global.ALL_WEAPON_TYPES); j++) {
				var wt = global.ALL_WEAPON_TYPES[j];
				ds_map_replace(weaponDamageMap,wt,0); // default +0% damage with weaponTypes
			}
			//ds_map_replace(basePlayerProperties,i,weaponDamageMap);
			ds_map_add_map(basePlayerProperties, i, weaponDamageMap);
			//ds_map_destroy(weaponDamageMap);
			break;
		}
	}
	
}

return basePlayerProperties;