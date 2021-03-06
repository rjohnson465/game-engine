// ACT 1
global.meleeWeaponsAct1 = [
	obj_hand_item_longsword, obj_hand_item_dagger, obj_hand_item_battleaxe, 
	obj_hand_item_foil, obj_hand_item_club, obj_hand_item_greatsword, 
	obj_hand_item_warhammer, obj_hand_item_spear, obj_hand_item_hatchet,
	obj_hand_item_wand
	];
global.rangedWeaponsAct1 = [
	obj_hand_item_shortbow, obj_hand_item_thrownknife, obj_hand_item_pistol,
	obj_hand_item_shuriken, obj_hand_item_arquebus, obj_hand_item_crossbow
	];
global.shieldsAct1 = [obj_hand_item_woodshield, obj_hand_item_buckler, obj_hand_item_kiteshield];

global.hatsAct1 = [obj_hat_leathercap, obj_hat_plated_cap, obj_hat_bike_helmet, obj_hat_ringed_coif];

global.meleeWeaponsByAct = ds_map_create();
global.shieldsByAct = ds_map_create();
global.rangedWeaponsByAct = ds_map_create();
global.hatsByAct = ds_map_create();

ds_map_replace(global.meleeWeaponsByAct,1,global.meleeWeaponsAct1);
ds_map_replace(global.rangedWeaponsByAct,1,global.rangedWeaponsAct1);
ds_map_replace(global.shieldsByAct,1,global.shieldsAct1);
ds_map_replace(global.hatsByAct,1,global.hatsAct1);