if !isLit exit;

lightAlpha = .3*cos((pi*floatingFrame)/30)+.7; // normal floating
floatingFrame += 1;
floatingFrame = floatingFrame % 120;

lightAlpha *= .4;

light_set_alpha(lightAlpha);