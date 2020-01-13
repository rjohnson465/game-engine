attackData = global.attackData;
owner = global.owner;
visible = true;
var s = attackData.spriteName+"_"+string(attackData.spriteAttackNumber)+"_"+string(attackData.spriteAttackNumberInChain)+"_projectile";
sprite_index = asset_get_index(s);

alarm[0] = attackData.underPlayerPrepDuration;