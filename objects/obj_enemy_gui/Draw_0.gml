//draw_path(owner.path,x,y,true);
draw_set_alpha(0.3);
//mp_grid_draw(owner.personalGrid);
draw_set_alpha(1);
if owner.layer != global.player.layer exit;
if owner.showHp {
	
	// totalhp bar outline
	var hpOutlineLeftX = owner.x-(.5*owner.sprite_width);
	var hpOutlineTopY = owner.y-(.5*owner.sprite_height)-10;
	var hpOutlineRightX = owner.x+(.5*owner.sprite_width);
	var hpOutlineBottomY = owner.y-(.5*owner.sprite_height)-5;
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
		
	
	/*
	// total stamina bar outline
	var x1 = owner.x-(.5*owner.sprite_width);
	var y1 = owner.y-(.5*owner.sprite_height)-20;
	var x2 = owner.x+(.5*owner.sprite_width);
	var y2 = owner.y-(.5*owner.sprite_height)-15;
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
		*/
}
