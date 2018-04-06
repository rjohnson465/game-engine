scale = .1*cos((pi*floatingFrame)/30)+.9; // normal floating

//draw_sprite_ext(sprite_index,image_index,x,y,scale,scale,0,c_white,.85);

floatingFrame += 1;
floatingFrame = floatingFrame % 60;