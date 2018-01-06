event_inherited();
spriteName = "magicmissile"; // i.e. magicmissile, fireball ...
name = "Magic Missile";
castFrames = 30; // how long spell can be charged
level = 5;
numberOfProjectiles = level;
projectileSpeed = 15;
staminaCost = 20;

maxChargeCost = level*4;

// per projectile
minDamage = 10;
maxDamage = 12;
//ds_map_add(damages,DamageTypes.Magic,3+(4*level));
//ds_map_add(damages,MAGIC,[10,12]); 