event_inherited();
origLayer = layer;
depth = layer_get_depth(layer)-5;
treeAlpha = 1;
sprite_index = spr_treedead1_mask
stopsAttacks = true;
material = WOOD;

// check every quarter second if a combatant is under tree (must draw transparent then)
treeAlpha = 1;
alarm[0] = 7;