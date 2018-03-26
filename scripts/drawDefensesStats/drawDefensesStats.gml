/// drawDefensesStats(startingY)
/// @param startingY
/// draw player defenses

var startingY = argument[0];
var p = global.player;
var line = 0;

draw_set_halign(fa_center);
draw_set_color(c_ltgray);
draw_text(mean(topLeftX,topLeftX+width),startingY+(line*20),"Defenses");
line++;
draw_set_halign(fa_left);
draw_set_color(c_white);

draw_sprite(spr_item_info_defense_physical,1,wdCol1XPictures,startingY+(line*20));
draw_text(wdCol1XText,startingY+(line*20),string(ds_map_find_value(p.defenses,PHYSICAL))+"%");
line++;

for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
	var el = global.ALL_ELEMENTS[i];
	var sprite = noone; 
	switch el {
		case MAGIC: {
			sprite = spr_item_info_defense_magic;
			break;
		}
		case FIRE: {
			sprite = spr_item_info_defense_fire;
			break;
		}
		case ICE: {
			sprite = spr_item_info_defense_ice;
			break;
		}
		case POISON: {
			sprite = spr_item_info_defense_poison;
			break;
		}
		case LIGHTNING: {
			sprite = spr_item_info_defense_lightning;
			break;
		}
	}
	draw_sprite(sprite,1,wdCol1XPictures,startingY+(line*20)+(i*20));
	draw_text(wdCol1XText,startingY+(line*20)+(i*20),string(ds_map_find_value(p.defenses,el))+"%");
}
line+=5;

draw_sprite(spr_stats_poise,1,wdCol1XPictures,startingY+(line*20));
draw_text(wdCol1XText,startingY+(line*20),"Poise: " + string(p.poise));
