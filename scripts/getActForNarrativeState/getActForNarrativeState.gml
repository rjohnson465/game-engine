/// getActForNarrativeState()

var p = global.player;
var ns = p.narrativeState;

var act1States = [
	NarrativeState.Start, 
	NarrativeState.LamplightFactory, 
	NarrativeState.WinterWonderground
];

var act2States = [];

var act3States = [];

var act4States = [];

var states = [act1States, act2States, act3States, act4States];

for (var i = 0; i < array_length_1d(states); i++) {
	var actStates = states[i];
	if arrayIncludes(actStates, ns) {
		return i+1;
	}
}