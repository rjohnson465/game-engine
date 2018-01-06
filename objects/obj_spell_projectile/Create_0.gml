event_inherited();
spriteName = "projectile"; // i.e. magicmissile, fireball ...
name = "Blast";
castFrames = 45; // how long spell can be charged
level = 1;
numberOfProjectiles = 1;
//projectileSpriteIndex = asset_get_index("spr_spell_"+ spriteName);
projectileSpeed = 30;
staminaCost = 25;

maxChargeCost = level*4;

ds_map_add(damages,DamageTypes.Magic,3+(10*level));