// condition outline
draw_set_alpha(.75);
draw_set_color(c_white);
var x1 = 10
var y1 = 100-(32)-20 + conditionBarNumber*25; 
var x2 = 100+(32);
var y2 = 100-(32)-15 + conditionBarNumber*25;

var spriteX = x2;
var spriteY = y1-5;
var sprite = noone;
draw_rectangle(x1,y1,x2,y2,true);
// current condition percent
var conditionPercent = ds_map_find_value(owner.conditionPercentages,condition);
conditionPercent = conditionPercent / 100;
var x2 = x1 + (122 * conditionPercent);
if (x2 < x1) x2 = x1;

switch condition {
	case FIRE: {
		draw_set_color(c_orange);
		sprite = spr_attunement_fire;
		break;
	}
	case ICE: {
		draw_set_color(c_white);
		sprite = spr_attunement_ice;
		break;
	}
	case POISON: {
		draw_set_color(c_green);
		sprite = spr_attunement_poison;
		break;
	}
	case LIGHTNING: {
		draw_set_color(c_yellow);
		sprite = spr_attunement_lightning;
		break;
	}
}
draw_sprite_ext(sprite,1,spriteX,spriteY,.5,.5,0,c_white,1);

var conditionLevel = ds_map_find_value(owner.conditionLevels,condition);
switch conditionLevel {
	case 0: {
		draw_set_alpha(.1);
	}
	case 1: {
		draw_set_alpha(.9);
	}
	case 2: {
		draw_set_alpha(1);
	}
}
draw_rectangle(x1,y1,x2,y2,false);


