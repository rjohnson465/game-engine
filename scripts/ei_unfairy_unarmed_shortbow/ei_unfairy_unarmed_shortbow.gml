/// ei_unfairy_unarmed_shortbow
/// initialize this unfairy to have no weapons
var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
ds_map_replace(handItems,"lm1",unarmed);
ds_map_replace(handItems,"rm1",unarmed);
ds_map_replace(equippedLimbItems,"l",unarmed);
ds_map_replace(equippedLimbItems,"r",unarmed);

var unarmedHook1 = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_1);
unarmedHook1.limbKey = "e";
var unarmedHook2 = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_1);
unarmedHook2.limbKey = "o";
var unarmedHook3 = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_1);
unarmedHook3.limbKey = "o";

var unarmedBackSlap = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_2);

var meleeChain1 = [unarmedHook1,unarmedHook2,unarmedHook3];
var meleeChain2 = [unarmedHook1,unarmedBackSlap];
var meleeChain3 = [unarmedHook1,unarmedBackSlap,unarmedHook2];
var meleeChain4 = [unarmedHook1,unarmedBackSlap,unarmedHook2,unarmedHook3];
meleeAttacks = [meleeChain1,meleeChain2,meleeChain3, meleeChain4];
meleeRangeArray = [5,5,5];

hp = 15;
maxHp = 15;

droppedItemsReplacement = ds_list_create();