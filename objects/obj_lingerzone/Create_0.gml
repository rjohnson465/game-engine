attackData = global.attackData;
depth = attackData.owner.depth;
lingerZonePartTypes = attackData.lingerZonePartTypes;
lingerZoneDuration = attackData.lingerZoneDuration;
lingerZoneDamages = attackData.lingerZoneDamages;
lingerZoneDamageFrequency = attackData.lingerZoneDamageFrequency;
var s = attackData.spriteName+"_"+string(attackData.spriteAttackNumber)+"_"+string(attackData.spriteAttackNumberInChain)+"_lingerzone";
sprite_index = asset_get_index(s);
alarm[0] = lingerZoneDuration;
alarm[1] = lingerZoneDamageFrequency;

hasSetAlarm = false;

system = part_system_create();
part_system_depth(system, depth);
emitter = part_emitter_create(system);
part_emitter_region(system, emitter, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_rectangle, ps_distr_gaussian);