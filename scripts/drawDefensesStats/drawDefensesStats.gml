/// drawDefensesStats(startingY)
/// @param startingY
/// draw player defenses

var startingY = argument[0];
var p = global.player;
var line = 0;

draw_set_halign(fa_center);
draw_set_color(c_ltgray);
draw_set_font(font_main);
draw_text(mean(topLeftX,topLeftX+width),startingY+(line*20),"Defenses");
line++;
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(font_small);

draw_sprite(spr_item_info_defense_slash,1,wdCol1XPictures,startingY+(line*20));
draw_text(wdCol1XText,startingY+(line*20),"vs. Slash: " + string(ds_map_find_value(p.defenses,SLASH)));
line++;
draw_sprite(spr_item_info_defense_crush,1,wdCol1XPictures,startingY+(line*20));
draw_text(wdCol1XText,startingY+(line*20),"vs. Crush: " + string(ds_map_find_value(p.defenses,CRUSH)));
line++;
draw_sprite(spr_item_info_defense_pierce,1,wdCol1XPictures,startingY+(line*20));
draw_text(wdCol1XText,startingY+(line*20),"vs. Pierce: " + string(ds_map_find_value(p.defenses,PIERCE)));
line++;

line -= 3;
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
	draw_sprite(sprite,1,basicCol2XPictures,startingY+(line*20)+(i*20));
	draw_text(basicCol2XText,startingY+(line*20)+(i*20),stringCapitalize(el) +": "+ string(ds_map_find_value(p.defenses,el))+"%");
}
line+=3;

draw_sprite(spr_stats_poise,1,wdCol1XPictures,startingY+(line*20));
draw_text(wdCol1XText,startingY+(line*20),"Poise: " + string(p.poise));
draw_set_font(font_main);
