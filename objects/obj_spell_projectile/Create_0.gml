event_inherited();
spriteName = "projectile"; // i.e. magicmissile, fireball ...
name = "Blast";
description = "Smite your foes with a powerful blast.";
skillSprite = spr_item_projectile_magic;

maxChargeCostByLevel = ds_map_create();
ds_map_replace(maxChargeCostByLevel,0,4);
ds_map_replace(maxChargeCostByLevel,1,5);
ds_map_replace(maxChargeCostByLevel,2,6);
ds_map_replace(maxChargeCostByLevel,3,6);
ds_map_replace(maxChargeCostByLevel,4,6);
ds_map_replace(maxChargeCostByLevel,5,8);
ds_map_replace(maxChargeCostByLevel,6,8);
ds_map_replace(maxChargeCostByLevel,7,10);
ds_map_replace(maxChargeCostByLevel,8,10);
ds_map_replace(maxChargeCostByLevel,9,12);
ds_map_replace(maxChargeCostByLevel,10,15);
damageRangesByLevel = ds_map_create();
ds_map_replace(damageRangesByLevel,0,[8,15]);
ds_map_replace(damageRangesByLevel,1,[10,18]);
ds_map_replace(damageRangesByLevel,2,[15,18]);
ds_map_replace(damageRangesByLevel,3,[18,22]);
ds_map_replace(damageRangesByLevel,4,[18,25]);
ds_map_replace(damageRangesByLevel,5,[20,28]);
ds_map_replace(damageRangesByLevel,6,[22,31]);
ds_map_replace(damageRangesByLevel,7,[25,32]);
ds_map_replace(damageRangesByLevel,8,[30,36]);
ds_map_replace(damageRangesByLevel,9,[35,41]);
ds_map_replace(damageRangesByLevel,10,[40,50]);

level = 0;
levelMax = 10;
projectileSpeed = 30;
staminaCost = 25;
staggerDuration = 20;
maxChargeCost = ds_map_find_value(maxChargeCostByLevel,level);

// per projectile
var range = ds_map_find_value(damageRangesByLevel,level);
minDamage = range[0];
maxDamage = range[1];
castFrames = 45; // how long spell can be charged
numberOfProjectiles = 1;