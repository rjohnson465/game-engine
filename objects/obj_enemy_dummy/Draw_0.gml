event_inherited();
//draw_path(path,x,y,true);
/*if showHp {
	
	// totalhp bar outline
	var x1 = x-(.5*sprite_width);
	var y1 = y-(.5*sprite_height)-20;
	var x2 = x+(.5*sprite_width);
	var y2 = y-(.5*sprite_height)-15;
	draw_set_color(c_white);
	draw_rectangle(x1,y1,x2,y2,true);
	// current hp
	var percentHpLeft = hp / maxHp;
	var x2 = x1 + (sprite_width * percentHpLeft);
	if (x2 < x1) x2 = x1;
	draw_set_color(c_red);
	draw_rectangle(
		x1,
		y1,
		x2,
		y2,
		false);
		
	// show currently lost / losing hp in yellow?
	var sustainingDamageObj = noone;
	var enemyId = id;
	with (obj_damage) {
		if victim == enemyId {
			sustainingDamageObj = id;
		}
	}
	if sustainingDamageObj {
		var sustainingDamage = sustainingDamageObj.amount;
		// top left corner of current hp bar's right side
		var x1 = x2;
		//var y1 = y1;
		var percentOfTotal = sustainingDamage / maxHp;
		var x2 = x1 + (sprite_width * percentOfTotal);
		//if (xx2 > x2) xx2 = x2;
		draw_set_color(c_ltgray);
		draw_rectangle(x1,y1,x2,y2,false);
	}
	
	
		
	// total stamina bar outline
	var x1 = x-(.5*sprite_width);
	var y1 = y-(.5*sprite_height)-10;
	var x2 = x+(.5*sprite_width);
	var y2 = y-(.5*sprite_height)-5;
	draw_set_color(c_white);
	draw_rectangle(x1,y1,x2,y2,true);
	// current stamina
	var percentStaminaLeft = stamina / maxStamina;
	var x2 = x1 + (sprite_width * percentStaminaLeft)
	if (x2 < x1) x2 = x1;
	draw_set_color(c_green);
	draw_rectangle(
		x1,
		y1,
		x2,
		y2,
		false);
	
	/* 
	// TODO
	// drain hp animation; per hit
	while !ds_list_empty(hitsToDrain) {
		var hit = ds_list_find_value(hitsToDrain,0);
		var totalFrames = hit.totalFrames;
		
		if hit.frame < totalFrames {
			var damage = hit.damage;
			
			var fractionOfHp = damage / totalHp;
			var drainX1 = x2;
			var drainY1 = y1;
		
			// calc drainX2
		
			var drainY2 = y2;
		} else {
			ds_list_delete(hitsToDrain,0);
		}
	}
		
}*/



