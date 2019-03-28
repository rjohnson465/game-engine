
if !isBoss {
	if id.showHp && id.isAlive && !id.isDying && layer == global.player.layer {
	
		// totalhp bar outline
		var vx = camera_get_view_x(view_camera[0]);
		var vy = camera_get_view_y(view_camera[0]);
		var spw = sprite_get_bbox_right(sprite_index)-sprite_get_bbox_left(sprite_index); 
		var sph = sprite_get_bbox_bottom(sprite_index)-sprite_get_bbox_top(sprite_index);
		var hpOutlineLeftX = (id.x-vx)-(.5*spw);
		var hpOutlineTopY = (id.y-vy)-(.5*sph)-10;
		var hpOutlineRightX = (id.x-vx)+(.5*spw);
		var hpOutlineBottomY = (id.y-vy)-(.5*sph)-5;
		draw_set_color(c_white);
		draw_rectangle(hpOutlineLeftX,hpOutlineTopY,hpOutlineRightX,hpOutlineBottomY,true);
	
		// current hp
		var percentHpLeft = id.hp / id.maxHp;
		var currentHpRightX = hpOutlineLeftX + (spw * percentHpLeft);
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
			var sustainingDamageRightX = sustainingDamageLeftX + (spw * percentOfTotal);
		
			// offset the damage right x to account for any hp regen or healing
			if healingSustained > 0 {
				var deltaPercent = healingSustained / id.maxHp;
				var xOff = spw * deltaPercent;
				sustainingDamageRightX -= xOff;
			}
		
			if sustainingDamageRightX > hpOutlineRightX {
				sustainingDamageRightX = hpOutlineRightX;
			}
		
			draw_set_color(c_ltgray);
			draw_rectangle(sustainingDamageLeftX,hpOutlineTopY,sustainingDamageRightX,hpOutlineBottomY,false);
		}
	
	

		var x1 = (id.x-vx)-(.5*spw);
		var y1 = (id.y-vy)-(.5*sph)-20;
		var x2 = (id.x-vx)+(.5*spw);
		var y2 = (id.y-vy)-(.5*sph)-15;
	
	
		draw_set_color(c_white);
		draw_rectangle(x1,y1,x2,y2,true);
		// current stamina
		var percentStaminaLeft = id.stamina / id.maxStamina;
		var x2 = x1 + (spw * percentStaminaLeft)
		if (x2 < x1) x2 = x1;
		draw_set_color(c_green);
		draw_rectangle(
			x1,
			y1,
			x2,
			y2,
			false);
	}


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
		draw_healthbar(x1,y1,x2,y2,percentHp,c_black,c_red,c_maroon,0,1,1);
		draw_set_color(c_white);
		draw_rectangle(x1,y1,x2,y2,1);
		draw_text(middleX,15,name);
		draw_set_font(font_small);
		scr_draw_text_outline(middleX,y2+2,id.description, c_white, c_white);
		draw_set_font(font_main);
	
		// draw conditions
		var conditionsList = ds_list_create();
		var curEl = ds_map_find_first(conditionPercentages);
		for (var i = 0; i < ds_map_size(conditionPercentages); i++) {
			var perc = ds_map_find_value(conditionPercentages, curEl);
			if perc > 0 {
				ds_list_add(conditionsList, curEl);
			}
			curEl = ds_map_find_next(conditionPercentages, curEl);
		}
	
		// now draw each active condition
		var xOff = 0;
		for (var i = 0; i < ds_list_size(conditionsList); i++) {
			var el = ds_list_find_value(conditionsList, i);
			var spr = asset_get_index("spr_attunement_"+el);
			var perc = ds_map_find_value(conditionPercentages, el);
			var hbWidth = x2 - x1;
			var reqCondiWidth = hbWidth / 5;
			var scale = reqCondiWidth / sprite_get_width(spr);
			if scale > .5 scale = .5;
			var sw = (sprite_get_width(spr)*scale);
			var sh = (sprite_get_height(spr)*scale);
		
			draw_sprite_ext(spr, 1, x1 + xOff, y2 + 25, scale, scale, 0, c_white, 1);
			// draw amount as colored bar
			var xx1 = x1+xOff; var xx2 = xx1 + sw;
			var yy1 = y2 + 25 + sh; var yy2 = yy1 + 3;
			var c = c_red;
			switch el {
				case MAGIC: {
					c = c_aqua; break;
				}
				case FIRE: {
					c = c_orange; break;
				}
				case ICE: {
					c = c_white; break;
				}
				case POISON: {
					c = c_green; break;
				}
				case LIGHTNING: {
					c = c_purple; break;
				}
			}
			draw_healthbar(xx1,yy1,xx2,yy2,perc,c_black,c,c,0,1,1);
		
			xOff += sw;
		}
	
		ds_list_destroy(conditionsList); conditionsList = -1;
	}
}
else if isBoss && isAlive {
	
	var index = 0;
	var Y_OFFSET = 50;
	with obj_enemy_parent {
		
		if isBoss {
			var yOff = Y_OFFSET * index;
			var y1 = BOSS_HP_Y1 - yOff; var y2 = BOSS_HP_Y2 - yOff;
			
			draw_healthbar(BOSS_HP_X1, y1, BOSS_HP_X2, y2, (hp/maxHp)*100, c_black, c_red, c_red, 0, true, true);
			draw_set_halign(fa_center); draw_set_valign(fa_center);
	
	
			var percentHpLeft = id.hp / id.maxHp;
			var bossHpBarWidth = BOSS_HP_X2 - BOSS_HP_X1;
			var currentHpRightX = BOSS_HP_X1 + (bossHpBarWidth * percentHpLeft);
	
			// show currently lost / losing hp in yellow?
			var sustainingDamageObj = noone;
			var enemyId = id;
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
				var sustainingDamageRightX = sustainingDamageLeftX + (bossHpBarWidth * percentOfTotal);
		
				// offset the damage right x to account for any hp regen or healing
				if healingSustained > 0 {
					var deltaPercent = healingSustained / id.maxHp;
					var xOff = bossHpBarWidth * deltaPercent;
					sustainingDamageRightX -= xOff;
				}
		
				if sustainingDamageRightX > BOSS_HP_X2 {
					sustainingDamageRightX = BOSS_HP_X2;
				}
		
				draw_set_color(c_ltgray);
				draw_rectangle(sustainingDamageLeftX,y1,sustainingDamageRightX,y2,false);
			}
	
			var name = id.name;
			scr_draw_text_outline(mean(BOSS_HP_X1, BOSS_HP_X2), mean(y1, y2), name, c_white, c_white);
			
			index++;
		}
	}

	
	
}

