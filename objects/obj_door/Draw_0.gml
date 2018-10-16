//prepareLayerShader();
if !isOpen {
	draw_sprite_ext(closedSprite,1,x,y,xscale,yscale,angle,c_white,1);
} else {
	if opensFrom == "l" || opensFrom == "a" {
		if spriteTurnsWhenOpen {
			if alarm[0] > 0 {
				var offset = ((-3*alarm[0])+90);
				draw_sprite_ext(openSprite,1,x,y,xscale,yscale,angle-offset,c_white,1);
			} else {
				draw_sprite_ext(openSprite,1,x,y,xscale,yscale,angle-90,c_white,1);
			}
		}
	} else if opensFrom == "r" || opensFrom == "b" {
		if spriteTurnsWhenOpen {
			draw_sprite_ext(openSprite,1,x,y,xscale,yscale,angle+90,c_white,1);
		}
	}
}
shader_reset();