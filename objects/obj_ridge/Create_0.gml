event_inherited();
postX = x;
postY = y;
fallDirectionString = noone;
fallDirectionMin = 0;
fallDirectionMax = 180;

scale = 1;
floatingFrame = 0;

randomize();
glowMin = 1;
glowMax = 8;
glowAmount = random_range(glowMin,glowMax); // (px offset for "glow" effect)
isGlowIncreasing = true;