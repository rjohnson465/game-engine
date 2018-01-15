if owner.showHp {
	
	// totalhp bar outline
	var x1 = owner.x-(.5*owner.sprite_width);
	var y1 = owner.y-(.5*owner.sprite_height)-20;
	var x2 = owner.x+(.5*owner.sprite_width);
	var y2 = owner.y-(.5*owner.sprite_height)-15;
	draw_set_color(c_white);
	draw_rectangle(x1,y1,x2,y2,true);
	// current hp
	var percentHpLeft = owner.hp / owner.maxHp;
	var x2 = x1 + (owner.sprite_width * percentHpLeft);
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
	var enemyId = owner.id;
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
		var percentOfTotal = sustainingDamage / owner.maxHp;
		var x2 = x1 + (owner.sprite_width * percentOfTotal);
		//if (xx2 > x2) xx2 = x2;
		draw_set_color(c_ltgray);
		draw_rectangle(x1,y1,x2,y2,false);
	}
	
	// total stamina bar outline
	var x1 = owner.x-(.5*owner.sprite_width);
	var y1 = owner.y-(.5*owner.sprite_height)-10;
	var x2 = owner.x+(.5*owner.sprite_width);
	var y2 = owner.y-(.5*owner.sprite_height)-5;
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
