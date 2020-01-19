var delta = .2;
if isGlowIncreasing && glowAmount >= glowMax {
	isGlowIncreasing = false;
} else if glowAmount <= glowMin {
	isGlowIncreasing = true;
}
if !isGlowIncreasing {
	delta*= -1;
}
glowAmount += delta;
