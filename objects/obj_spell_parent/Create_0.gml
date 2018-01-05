enum SpellTypes {
	Martial,
	Healing
}

name = ""; // i.e. magicmissile, fireball ...
type = SpellTypes.Martial;
castFrames = 30; // how long spell can be charged
numberOfProjectiles = 1;
projectileSpriteIndex = asset_get_index("spr_spell_"+ name);
projectileSpeed = 0;
staminaCost = 0;

maxChargeCost = 10;

damages = ds_map_create();
