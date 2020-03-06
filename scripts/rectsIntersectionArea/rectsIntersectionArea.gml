/// rectsIntersectionArea(r1x1, r1y1, r1x2, r1y2, r2x1, r2y1, r2x2, r2y2)
/// @param r1x1
/// @param r1y1
/// @param r1x2
/// @param r1y2
/// @param r2x1
/// @param r2y1
/// @param r2x2
/// @param r2y2

var r1x1 = argument[0];
var r1y1 = argument[1];
var r1x2 = argument[2];
var r1y2 = argument[3];
var r2x1 = argument[4];
var r2y1 = argument[5];
var r2x2 = argument[6];
var r2y2 = argument[7];


// get the intersection rect -- if area v small, do nothing
var leftX = max(r1x1, r2x1);
var rightX = min(r1x2, r2x2);
var topY = max(r1y1, r2y1);
var bottomY = min(r1y2, r2y2);
		
var area = 0;
if (leftX < rightX && topY < bottomY) {
	var lx = leftX; var ty = topY;
	var rx = lx + (rightX - leftX); var by = ty + (bottomY - topY);
	var rectw = rx - lx; var recth = by - ty;
	area = rectw * recth;
				
}

return area;