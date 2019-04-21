/// rotateAndTranslatePoint(origX, origY, xOffset, yOffset, angle)
/// @param origX
/// @param origY
/// @param xOffset
/// @param yOffset
/// @param angle 

var cx = argument[0];
var cy = argument[1];
var xo = argument[2];
var yo = argument[3];
var angle = argument[4];
		
var radians = (pi/180) * angle;
var cs = cos(radians);
var sn = sin(radians);

		
var sx1 = cx + xo; var sy1 = cy + yo;
var nx1 = (cs * (sx1 - cx)) + (sn * (sy1 - cy)) + cx;
var ny1 = (cs * (sy1 - cy)) - (sn * (sx1 - cx)) + cy;

return [nx1, ny1];
		
