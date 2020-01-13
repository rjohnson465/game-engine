event_inherited();
origLayer = layer;
depth = layer_get_depth(layer)-4;

sprite_index = spr_tree1_mask;
stopsAttacks = true;
material = WOOD;

// check every quarter second if a combatant is under tree (must draw transparent then)
treeAlpha = 1;
alarm[0] = 7;

drawScaleX = image_xscale;
drawScaleY = image_yscale;

// trunk collision is always smal
image_xscale = 1;
image_yscale = 1;