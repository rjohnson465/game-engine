// set state to heal / eat, reset hunger frame
state = "Eat";
randomize();
alarm[2] = round(random_range(HUNGER_FRAME_MIN, HUNGER_FRAME_MAX));