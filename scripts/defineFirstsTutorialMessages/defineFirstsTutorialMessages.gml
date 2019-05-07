/// defineFirstsTutorialMessages()

/// a map of context-dependent tutorial messages that happen the first time some event is triggered
// values are true or false (if the tut message has been displayed yet)
// this function should only be called once, at the start of a new game

enum TutFirsts {
	BrokenItems,
	GemmedItems,
	Gems,
	TwoHandedRangedWeapons,
	LevelingUp,
	Hats,
	Rings,
	Shields,
	Experience,
	SpecialHats,
	HealthOrbs,
	length
}

var map = ds_map_create();
for (var i = 0; i < TutFirsts.length; i++) {
	ds_map_replace(map, i, false);
}

return map;