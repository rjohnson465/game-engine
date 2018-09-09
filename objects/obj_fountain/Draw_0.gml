//if (global.player.depth > depth && abs(abs(global.player.depth)-abs(depth) > 5)) exit;
//else {
	prepareLayerShader();
	draw_sprite(sprite_index,image_index,x,y);
	shader_reset();
//}

