limbKey = global.limbKey;
owner = global.owner;
limbItem = ds_map_find_value(owner.equippedLimbItems, limbKey);

spriteString = "spr_"+owner.spriteString+"_"+limbItem.spriteName;
layer = owner.layer;


// particle system for elemental effects
refreshParticles = false;
system = part_system_create();
part_system_depth(system,layer_get_depth(owner.layer));
emitter = part_emitter_create(system);
weaponParticles = [noone, noone, noone, noone, noone];
weaponParticlesNums = [noone, noone, noone, noone, noone];


updateWeaponParticles(limbItem);

hasHematite = false;