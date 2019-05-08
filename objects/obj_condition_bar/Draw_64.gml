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
var sprScale = .5;

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
		draw_set_color(c_purple);
		sprite = spr_attunement_lightning;
		break;
	}
	case MAGIC: {
		draw_set_color(c_aqua);
		sprite = spr_attunement_magic;
		break;
	}
	case PIERCE: {
		sprite = spr_item_spearmint_elixir;
		sprScale = .3125;
		draw_set_color(c_gray);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,0);
		draw_set_color(c_black);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,1);
		draw_set_color(make_color_rgb(93,255,186));
		break;
	}
	case CRUSH: {
		sprite = spr_item_club_soda;
		sprScale = .3125;
		draw_set_color(c_gray);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,0);
		draw_set_color(c_black);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,1);
		draw_set_color(c_silver);
		break;
	}
	case SLASH: {
		sprite = spr_item_razorade;
		sprScale = .3125;
		draw_set_color(c_gray);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,0);
		draw_set_color(c_black);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,1);
		draw_set_color(make_color_rgb(125,89,145));
		break;
	}
	default: {
		// The default case is that the condition is named after the sprite used to display it
		sprite = asset_get_index(condition);
		sprScale = .3125;
		draw_set_color(c_gray);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,0);
		draw_set_color(c_black);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,1);
		draw_set_color(c_white);
		if sprite == "spr_item_lamplight" {
			draw_set_color(c_aqua);
		}
		break;
	}
}
draw_sprite_ext(sprite,1,spriteX,spriteY,sprScale,sprScale,0,c_white,1);

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


