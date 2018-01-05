event_inherited();
spriteName = "aoe"; // i.e. magicmissile, fireball ...
name = "Explosion";
castFrames = 45; // how long spell can be charged
level = 1;
numberOfProjectiles = 8;
//projectileSpriteIndex = asset_get_index("spr_spell_"+ spriteName);
projectileSpeed = 20;
staminaCost = 25;

maxChargeCost = level*6;

ds_map_add(damages,DamageTypes.Magic,3+(6*level));