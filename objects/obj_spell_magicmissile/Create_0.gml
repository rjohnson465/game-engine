event_inherited();
spriteName = "magicmissile"; // i.e. magicmissile, fireball ...
name = "Magic Missile";
description = "Shoot magical projectiles that track enemies.";
castFrames = 30; // how long spell can be charged
skillSprite = spr_item_magicmissile_magic;

damageRangesByLevel = ds_map_create();
ds_map_replace(damageRangesByLevel,0,[4,8]); // 1 projectile
ds_map_replace(damageRangesByLevel,1,[4,6]); // 2 projectiles
ds_map_replace(damageRangesByLevel,2,[4,6]); // 3 projectiles
ds_map_replace(damageRangesByLevel,3,[6,8]);
ds_map_replace(damageRangesByLevel,4,[7,9]);
ds_map_replace(damageRangesByLevel,5,[8,10]);
ds_map_replace(damageRangesByLevel,6,[6,8]); // 4 projectiles
ds_map_replace(damageRangesByLevel,7,[7,9]);
ds_map_replace(damageRangesByLevel,8,[6,8]); // 5 projectiles
ds_map_replace(damageRangesByLevel,9,[8,9]);
ds_map_replace(damageRangesByLevel,10,[8,10]);
numberOfProjectilesByLevel = ds_map_create();
ds_map_replace(numberOfProjectilesByLevel,0,1);
ds_map_replace(numberOfProjectilesByLevel,1,2);
ds_map_replace(numberOfProjectilesByLevel,2,3);
ds_map_replace(numberOfProjectilesByLevel,3,3);
ds_map_replace(numberOfProjectilesByLevel,4,3);
ds_map_replace(numberOfProjectilesByLevel,5,3);
ds_map_replace(numberOfProjectilesByLevel,6,4);
ds_map_replace(numberOfProjectilesByLevel,7,4);
ds_map_replace(numberOfProjectilesByLevel,8,5);
ds_map_replace(numberOfProjectilesByLevel,9,5);
ds_map_replace(numberOfProjectilesByLevel,10,5);
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

level = 0;
levelMax = 10;
numberOfProjectiles = ds_map_find_value(numberOfProjectilesByLevel,level);

maxChargeCost = ds_map_find_value(maxChargeCostByLevel,level);

// per projectile
var range = ds_map_find_value(damageRangesByLevel,level);
minDamage = range[0];
maxDamage = range[1];

staminaCost = 20;
staggerDuration = 5;
projectileSpeed = 15;