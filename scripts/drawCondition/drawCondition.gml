/// drawCondition(alpha, conditionBarNumber, conditionPercent, condiSprite, condiSprScale, doDrawSprBackground, condiColor)
/// @param alpha
/// @param conditionBarNumber
/// @param conditionPercent
/// @param condiSprite
/// @param condiSprScale
/// @param doDrawSprBackground
/// @param condiColor

var alpha = argument[0];
var conditionBarNumber = argument[1];
var conditionPercent = argument[2];
var sprite = argument[3];
var sprScale = argument[4];
var doDrawSprBackground = argument[5];
var condiColor = argument[6];

// condition outline
draw_set_alpha(.75);
draw_set_color(c_white);
var x1 = 10
var y1 = 100-(32)-20 + conditionBarNumber*25; 
var x2 = 100+(32);
var y2 = 100-(32)-15 + conditionBarNumber*25;

var spriteX = x2;
var spriteY = y1-5;

if doDrawSprBackground {
	draw_set_color(c_gray);
	draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,0);
	draw_set_color(c_black);
	draw_rectangle(spriteX, spriteY, spriteX+20, spriteY+20,1);
	draw_set_color(c_white);
}
draw_rectangle(x1,y1,x2,y2,true);

conditionPercent = conditionPercent / 100;
var x2 = x1 + (122 * conditionPercent);
if (x2 < x1) x2 = x1;

draw_sprite_ext(sprite,1,spriteX,spriteY,sprScale,sprScale,0,c_white,alpha);

draw_set_alpha(alpha); draw_set_color(condiColor);
draw_rectangle(x1,y1,x2,y2,false);
draw_set_alpha(1);
