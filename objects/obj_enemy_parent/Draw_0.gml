event_inherited();

draw_set_color(c_lime);
draw_path(path,x,y,0);
draw_set_color(c_aqua);
draw_path(gridPath,x,y,0);

draw_set_alpha(.2);
mp_grid_draw(personalGrid);