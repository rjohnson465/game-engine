/// getDefaultGemTypeChanceMap()

var map = ds_map_create();
var allGemTypes = [obj_gem_hematite, obj_gem_lapis, obj_gem_ruby, obj_gem_aquamarine, obj_gem_emerald, obj_gem_amethyst];
var chanceMax = 100; var diff = 100/array_length_1d(allGemTypes);
for (var i = 0; i < array_length_1d(allGemTypes); i++) {
	var gemIndex = allGemTypes[i];
	ds_map_replace(map,gemIndex,[chanceMax-diff,chanceMax]);
	chanceMax -= diff;
}

return map;