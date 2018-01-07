// condition outline
draw_set_alpha(.75);
var x1 = 100-(32);
var y1 = 100-(32)-20 + conditionBarNumber*25; 
var x2 = 100+(32);
var y2 = 100-(32)-15 + conditionBarNumber*25;
draw_set_color(c_white);
draw_set_font(font_main);
draw_text(x2,y1,condition);
draw_rectangle(x1,y1,x2,y2,true);
// current condition percent
var conditionPercent = ds_map_find_value(owner.conditionPercentages,condition);
conditionPercent = conditionPercent / 100;
var x2 = x1 + (64 * conditionPercent);
if (x2 < x1) x2 = x1;

switch condition {
	case FIRE: {
		draw_set_color(c_orange);
		break;
	}
	case ICE: {
		draw_set_color(c_white);
		break;
	}
	case POISON: {
		draw_set_color(c_green);
		break;
	}
	case LIGHTNING: {
		draw_set_color(c_yellow);
		break;
	}
	case BLEED: {
		draw_set_color(c_yellow);
		break;
	}
}

var conditionLevel = ds_map_find_value(owner.conditionLevels,condition);
switch conditionLevel {
	case 0: {
		draw_set_alpha(.25);
	}
	case 1: {
		draw_set_alpha(.75);
	}
	case 2: {
		draw_set_alpha(1);
	}
}

draw_rectangle(x1,y1,x2,y2,false);


