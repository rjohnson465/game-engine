event_inherited();
spriteName = "magicmissile"; // i.e. magicmissile, fireball ...
name = "Magic Missile";
castFrames = 30; // how long spell can be charged
level = 5;
numberOfProjectiles = level;
//projectileSpriteIndex = asset_get_index("spr_spell_"+ spriteName);
projectileSpeed = 15;
staminaCost = 20;

maxChargeCost = level*4;

ds_map_add(damages,DamageTypes.Magic,3+(4*level));