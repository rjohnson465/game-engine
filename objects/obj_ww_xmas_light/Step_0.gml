lightAlpha = .1*cos((pi*floatingFrame)/30)+.9; // normal floating
floatingFrame += 1;
floatingFrame = floatingFrame % 120;

lightAlpha *= .7;

light_set_alpha(lightAlpha);