// ACT 1
global.meleeWeaponsAct1 = [obj_hand_item_longsword, obj_hand_item_dagger, obj_hand_item_battleaxe, obj_hand_item_foil];
global.rangedWeaponsAct1 = [obj_hand_item_shortbow, obj_hand_item_thrownknife, obj_hand_item_pistol];
global.shieldsAct1 = [obj_hand_item_woodshield];

global.hatsAct1 = [obj_hat_leathercap];

global.meleeWeaponsByAct = ds_map_create();
global.shieldsByAct = ds_map_create();
global.rangedWeaponsByAct = ds_map_create();
global.hatsByAct = ds_map_create();

ds_map_replace(global.meleeWeaponsByAct,1,global.meleeWeaponsAct1);
ds_map_replace(global.rangedWeaponsByAct,1,global.rangedWeaponsAct1);
ds_map_replace(global.shieldsByAct,1,global.shieldsAct1);
ds_map_replace(global.hatsByAct,1,global.hatsAct1);