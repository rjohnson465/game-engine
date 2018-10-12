/// ei_unfairy_spear	
/// initialize this unfairy to have a spear and no ranged
var unarmed = instance_create_depth(x,y,1,obj_hand_item_unarmed);
var spear = instance_create_depth(x,y,1,obj_hand_item_spear);
ds_map_replace(handItems,"lm1",spear);
ds_map_replace(handItems,"rm1",unarmed);
ds_map_replace(equippedLimbItems,"l",spear);
ds_map_replace(equippedLimbItems,"r",unarmed);

var spearStab = instance_create_depth(x,y,1,obj_attack_unfairy_spear_1_1);
spearStab.limbKey = "l";
var spearStab2 = instance_create_depth(x,y,1,obj_attack_unfairy_spear_1_2);

var meleeChain1 = [spearStab];
var meleeChain2 = [spearStab,spearStab2];
meleeAttacks = [meleeChain1,meleeChain2];
meleeRangeArray = [100,100];

attackFrequencyTotalFramesMelee = [25,45];