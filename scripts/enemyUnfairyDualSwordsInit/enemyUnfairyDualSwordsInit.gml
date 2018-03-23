/// enemyUnfairyDualSwordsInit()	

/// initialize this unfairy to have 2 longswords

var longsword1 = instance_create_depth(x,y,1,obj_hand_item_longsword);
var longsword2 = instance_create_depth(x,y,1,obj_hand_item_longsword);
ds_map_replace(handItems,"lm1",longsword1);
ds_map_replace(handItems,"rm1",longsword2);
ds_map_replace(equippedLimbItems,"l",longsword1);
ds_map_replace(equippedLimbItems,"r",longsword2);

// for particle effects
ds_map_replace(longsword2.damages,LIGHTNING,[1,2]);
ds_map_replace(longsword1.damages,ICE,[1,2]);

// ATTACKS
global.owner = id;
var longswordSwing1 = instance_create_depth(x,y,1,obj_attack_unfairy_longsword_1_1);
longswordSwing1.limbKey = "l";
ds_map_replace(longswordSwing1.damages,ICE,[1,2]);
var longswordSwing2 = instance_create_depth(x,y,1,obj_attack_unfairy_longsword_1_1);
longswordSwing2.limbKey = "o";
ds_map_replace(longswordSwing2.damages,LIGHTNING,[1,2]);

var longswordStabFire = instance_create_depth(x,y,1,obj_attack_unfairy_longsword_2_1);
longswordStabFire.limbKey = "r";
ds_map_replace(longswordStabFire.damages,LIGHTNING,[3,5]);

var longswordStabPoison = instance_create_depth(x,y,1,obj_attack_unfairy_longsword_2_1);
longswordStabPoison.limbKey = "l";
ds_map_replace(longswordStabPoison.damages,ICE,[3,5]);

var meleeChain0 = [longswordSwing1,longswordSwing2];
var meleeChain1 = [longswordStabFire];
var meleeChain2 = [longswordStabPoison];
meleeAttacks = [meleeChain0,meleeChain1,meleeChain2];
meleeRangeArray = [15,65,65];