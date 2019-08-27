/// getConditionData(condition)
/// returns [color, sprite, spriteScale, doDrawSpriteBackground]
/// @param condition

var condition = argument[0];
var c = noone;
var sprite = noone;
var sprScale = .5;
var doDrawSpriteBackground = false;

switch condition {
	case FIRE: {
		c = c_orange;
		sprite = spr_attunement_fire;
		break;
	}
	case ICE: {
		c = c_white;
		sprite = spr_attunement_ice;
		break;
	}
	case POISON: {
		c = c_green;
		sprite = spr_attunement_poison;
		break;
	}
	case LIGHTNING: {
		c = c_purple;
		sprite = spr_attunement_lightning;
		break;
	}
	case MAGIC: {
		c = c_aqua;
		sprite = spr_attunement_magic;
		break;
	}
	case PIERCE: {
		sprite = spr_item_spearmint_elixir;
		sprScale = .3125;
		doDrawSpriteBackground = true;
		/*draw_set_color(c_gray);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,0);
		draw_set_color(c_black);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,1);*/
		c = make_color_rgb(93,255,186);
		break;
	}
	case CRUSH: {
		sprite = spr_item_club_soda;
		sprScale = .3125;
		doDrawSpriteBackground = true;
		/*draw_set_color(c_gray);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,0);
		draw_set_color(c_black);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,1);*/
		c = c_silver;
		break;
	}
	case SLASH: {
		sprite = spr_item_razorade;
		sprScale = .3125;
		doDrawSpriteBackground = true;
		/*draw_set_color(c_gray);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,0);
		draw_set_color(c_black);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,1);*/
		c = make_color_rgb(125,89,145);
		break;
	}
	default: {
		// The default case is that the condition is named after the sprite used to display it
		sprite = asset_get_index(condition);
		sprScale = .3125;
		c = c_gray;
		doDrawSpriteBackground = true;
		/*draw_set_color(c_gray);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,0);
		draw_set_color(c_black);
		draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,1);
		draw_set_color(c_white);*/
		if sprite == "spr_item_lamplight" {
			c = c_aqua;
		}
		break;
	}
}

return [c, sprite, sprScale, doDrawSpriteBackground];