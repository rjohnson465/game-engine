/// ei_icecursedfairy_baxe_ice

var hatchet = makeEnemyWeapon(obj_hand_item_hatchet);
var baxe = makeEnemyWeapon(obj_hand_item_baxe);

ds_map_replace(handItems,"lm1",baxe);
ds_map_replace(handItems,"rm1",hatchet);

rangedRangeArray = []; rangedAttacks = [];
ds_map_replace(equippedLimbItems,"l",baxe);
ds_map_replace(equippedLimbItems,"r",hatchet);

var baxe1 = instance_create_depth(x, y, 1, obj_attack_icecursedfairy_baxe_1_1);
var baxe2 = instance_create_depth(x, y, 1, obj_attack_icecursedfairy_baxe_1_2);

// for particle effects
ds_map_replace(baxe.damages,ICE,[1,2]);

ds_map_replace(baxe1.damages, ICE, [6,6]);
ds_map_replace(baxe2.damages, ICE, [6,6]);


var c1 = [baxe1];
var c2 = [baxe1, baxe2];
meleeAttacks = [c1, c2];


attackFrequencyTotalFramesMelee = [60,80];