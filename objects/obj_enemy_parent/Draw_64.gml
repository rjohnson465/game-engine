// if player is locked on to this enemy, view hp / name in top middle screen
if id == global.player.lockOnTarget {
	draw_set_font(font_main);
	var name = id.name;
	var nameWidth = string_width(name);
	var nameHeight = string_height(name);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	var middleX = view_get_wport(view_camera[0])/2;
	
	var projectedWidth = nameWidth+20;
	var widthBuffer = 10;
	if projectedWidth < 250 {
		var diff = 250 - projectedWidth;
		widthBuffer = diff / 2;
	}
	
	var x1 = middleX-(.5*nameWidth)-widthBuffer;
	var y1 = 11;
	var x2 = middleX+(.5*nameWidth)+widthBuffer;
	var y2 = 15+nameHeight;
	var percentHp = (id.hp / id.maxHp)*100;
	// percentX 
	var width = x2 - x1; var perDec = percentHp/100;
	var px = x1+(width*perDec);
	/*texFrame = (texFrame + 1) % texFrameTotals;
	
	draw_set_colour(c_red);
	//var tex = background_get_texture(background0);
	var tex = sprite_get_texture(spr_texture_clouds_red,texFrame);
	//draw_primitive_begin_texture(pr_trianglelist, tex);
	// triangle 1
	draw_vertex_texture(x1, y1, 0, 0);
	draw_vertex_texture(x1, y2, 1, 0);
	draw_vertex_texture(px,y2, perDec, 1);
	// triangle 2
	draw_vertex_texture(px,y1, perDec, 1);
	draw_vertex_texture(x1,y1, 0, 1);
	draw_vertex_texture(px,y2, perDec, 1);
	draw_primitive_end();
	draw_primitive_begin_texture(pr_trianglestrip, tex);
	draw_vertex_texture(x1, y2, 0, 1);
	draw_vertex_texture(x1, y1, 0, 0);
	draw_vertex_texture(px, y2, 1*perDec, 1);
	draw_vertex_texture(px, y1, 1*perDec, 0);
	draw_primitive_end();*/
	draw_healthbar(x1,y1,x2,y2,percentHp,c_black,c_red,c_maroon,0,1,1);
	draw_set_color(c_white);
	draw_rectangle(x1,y1,x2,y2,1);
	draw_text(middleX,15,name);
	draw_set_font(font_small);
	draw_text(middleX,y2+2,id.description);
	draw_set_font(font_main);
}

//draw_path(id.path,x,y,true);
//draw_path(id.gridPath,x,y,true);
draw_set_alpha(0.3);
//mp_grid_draw(id.personalGrid);
draw_set_alpha(1);
if id.layer != global.player.layer exit;
if id.showHp && id.isAlive && !id.isDying {
	
	
	
	// totalhp bar outline
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	var hpOutlineLeftX = (id.x-vx)-(.5*id.sprite_width);
	var hpOutlineTopY = (id.y-vy)-(.5*id.sprite_height)-10;
	var hpOutlineRightX = (id.x-vx)+(.5*id.sprite_width);
	var hpOutlineBottomY = (id.y-vy)-(.5*id.sprite_height)-5;
	draw_set_color(c_white);
	draw_rectangle(hpOutlineLeftX,hpOutlineTopY,hpOutlineRightX,hpOutlineBottomY,true);
	
	// current hp
	var percentHpLeft = id.hp / id.maxHp;
	var currentHpRightX = hpOutlineLeftX + (id.sprite_width * percentHpLeft);
	if (currentHpRightX < hpOutlineLeftX) currentHpRightX = hpOutlineLeftX;
	draw_set_color(c_red);
	draw_rectangle(
		hpOutlineLeftX,
		hpOutlineTopY,
		currentHpRightX,
		hpOutlineBottomY,
		false);
		
	// show currently lost / losing hp in yellow?
	var sustainingDamageObj = noone;
	var enemyId = id.id;
	with (obj_damage) {
		if victim == enemyId {
			sustainingDamageObj = id;
		}
	}
	if sustainingDamageObj {
		
		// this is how much hp the enemy had when the first damage in this group was leveled against it
		var healingSustained = sustainingDamageObj.healingSustained;
		
		var sustainingDamage = sustainingDamageObj.amount;
		// top right corner of current hp bar
		var sustainingDamageLeftX = currentHpRightX;
		var percentOfTotal = sustainingDamage / id.maxHp;
		var sustainingDamageRightX = sustainingDamageLeftX + (id.sprite_width * percentOfTotal);
		
		// offset the damage right x to account for any hp regen or healing
		if healingSustained > 0 {
			var deltaPercent = healingSustained / id.maxHp;
			var xOff = id.sprite_width * deltaPercent;
			sustainingDamageRightX -= xOff;
		}
		
		if sustainingDamageRightX > hpOutlineRightX {
			sustainingDamageRightX = hpOutlineRightX;
		}
		
		draw_set_color(c_ltgray);
		draw_rectangle(sustainingDamageLeftX,hpOutlineTopY,sustainingDamageRightX,hpOutlineBottomY,false);
	}
		
	
	
	// total stamina bar outline
	var x1 = (id.x-vx)-(.5*id.sprite_width);
	var y1 = (id.y-vy)-(.5*id.sprite_height)-20;
	var x2 = (id.x-vx)+(.5*id.sprite_width);
	var y2 = (id.y-vy)-(.5*id.sprite_height)-15;
	draw_set_color(c_white);
	draw_rectangle(x1,y1,x2,y2,true);
	// current stamina
	var percentStaminaLeft = id.stamina / id.maxStamina;
	var x2 = x1 + (id.sprite_width * percentStaminaLeft)
	if (x2 < x1) x2 = x1;
	draw_set_color(c_green);
	draw_rectangle(
		x1,
		y1,
		x2,
		y2,
		false);
		
}
