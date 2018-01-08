event_inherited();
spriteName = "aoe"; // i.e. magicmissile, fireball ...
name = "Explosion";
castFrames = 45; // how long spell can be charged
level = 1;
numberOfProjectiles = 8;
projectileSpeed = 20;
staminaCost = 25;

maxChargeCost = level*6;
// per projectile
minDamage = 10;
maxDamage = 15;
// damage per projectile
//ds_map_add(damages,MAGIC,[5,10]); 