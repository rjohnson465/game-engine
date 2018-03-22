event_inherited();
spriteName = "magicmissile"; // i.e. magicmissile, fireball ...
name = "Magic Missile";
castFrames = 30; // how long spell can be charged
level = 3;
numberOfProjectiles = level;
projectileSpeed = 15;
staminaCost = 20;

staggerDuration = 5;
// make it dependent on level?
maxChargeCost = 4;

// per projectile
minDamage = 4;
maxDamage = 8;
//ds_map_add(damages,DamageTypes.Magic,3+(4*level));
//ds_map_add(damages,MAGIC,[10,12]); 