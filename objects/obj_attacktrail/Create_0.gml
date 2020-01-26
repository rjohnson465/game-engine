attackData = global.attackData;
if attackData.limbKey == "l" {
	image_yscale = -1;
}
owner = attackData.owner;
particle = attackData.trailPart;
system = part_system_create();
part_system_depth(system, layer_get_depth(owner.layer)-1);
emitter = part_emitter_create(system);

hasSetAlarm = false;

// var sprStr = attackData.spriteName + "_attack_" + string(attackData.spriteAttackNumber) + "_" + string(attackData.spriteAttackNumberInChain);
var maskStr = attackData.spriteName + "_attack_" + string(attackData.spriteAttackNumber) + "_" + string(attackData.spriteAttackNumberInChain) + "_trail";
sprite_index = asset_get_index(maskStr);