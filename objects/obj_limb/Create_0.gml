owner = global.owner;
limbKey = global.limbKey;
limbItem = ds_map_find_value(owner.equippedLimbItems,limbKey);
persistent = global.isPersistent;
layer = owner.layer;

global.limb = id;
instance_create_depth(x,y,1,obj_weapon);

spriteString = "";

if owner.type != CombatantTypes.Player {
	spriteString = "spr_"+owner.spriteString + "_limb_" + limbItem.name;
} 

if limbKey == "l" {
	image_yscale = -1;
}

sprite_index = asset_get_index(spriteString);

// particle system for spell casting
particle = part_type_create();
system = part_system_create();
part_system_depth(system,depth);
emitter = part_emitter_create(system);

