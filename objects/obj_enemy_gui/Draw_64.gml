//draw_path(owner.path,x,y,1);
draw_set_alpha(.1);
//mp_grid_draw(owner.personalGrid);
draw_set_alpha(1);
// if player is locked on to this enemy, view hp / name in top middle screen
if owner == global.player.lockOnTarget {
	draw_set_font(font_main);
	var name = owner.name;
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
	var percentHp = (owner.hp / owner.maxHp)*100;
	
	draw_healthbar(x1,y1,x2,y2,percentHp,c_black,c_red,c_maroon,0,1,1);
	draw_set_color(c_white);
	draw_rectangle(x1,y1,x2,y2,1);
	draw_text(middleX,15,name);
	draw_set_font(font_small);
	draw_text(middleX,y2+2,owner.description);
	draw_set_font(font_main);
}

//draw_path(owner.path,x,y,true);
//draw_path(owner.gridPath,x,y,true);
draw_set_alpha(0.3);
//mp_grid_draw(owner.personalGrid);
draw_set_alpha(1);
if owner.layer != global.player.layer exit;
if owner.showHp && owner.isAlive && !owner.isDying {
	
	
	
	// totalhp bar outline
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	var hpOutlineLeftX = (owner.x-vx)-(.5*owner.sprite_width);
	var hpOutlineTopY = (owner.y-vy)-(.5*owner.sprite_height)-10;
	var hpOutlineRightX = (owner.x-vx)+(.5*owner.sprite_width);
	var hpOutlineBottomY = (owner.y-vy)-(.5*owner.sprite_height)-5;
	draw_set_color(c_white);
	draw_rectangle(hpOutlineLeftX,hpOutlineTopY,hpOutlineRightX,hpOutlineBottomY,true);
	
	// current hp
	var percentHpLeft = owner.hp / owner.maxHp;
	var currentHpRightX = hpOutlineLeftX + (owner.sprite_width * percentHpLeft);
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
	var enemyId = owner.id;
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
		var percentOfTotal = sustainingDamage / owner.maxHp;
		var sustainingDamageRightX = sustainingDamageLeftX + (owner.sprite_width * percentOfTotal);
		
		// offset the damage right x to account for any hp regen or healing
		if healingSustained > 0 {
			var deltaPercent = healingSustained / owner.maxHp;
			var xOff = owner.sprite_width * deltaPercent;
			sustainingDamageRightX -= xOff;
		}
		
		if sustainingDamageRightX > hpOutlineRightX {
			sustainingDamageRightX = hpOutlineRightX;
		}
		
		draw_set_color(c_ltgray);
		draw_rectangle(sustainingDamageLeftX,hpOutlineTopY,sustainingDamageRightX,hpOutlineBottomY,false);
	}
		
	
	
	// total stamina bar outline
	var x1 = (owner.x-vx)-(.5*owner.sprite_width);
	var y1 = (owner.y-vy)-(.5*owner.sprite_height)-20;
	var x2 = (owner.x-vx)+(.5*owner.sprite_width);
	var y2 = (owner.y-vy)-(.5*owner.sprite_height)-15;
	draw_set_color(c_white);
	draw_rectangle(x1,y1,x2,y2,true);
	// current stamina
	var percentStaminaLeft = owner.stamina / owner.maxStamina;
	var x2 = x1 + (owner.sprite_width * percentStaminaLeft)
	if (x2 < x1) x2 = x1;
	draw_set_color(c_green);
	draw_rectangle(
		x1,
		y1,
		x2,
		y2,
		false);
		
}
