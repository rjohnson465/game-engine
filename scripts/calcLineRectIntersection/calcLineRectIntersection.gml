/// calcLineRectIntersection(rectX1, rectY1, rectX2, rectY2, x1, y1, x2, y2);
var rx1 = argument[0];
var ry1 = argument[1];
var rx2 = argument[2];
var ry2 = argument[3];
var x1 = argument[4];
var y1 = argument[5];
var x2 = argument[6];
var y2 = argument[7];

// forumla for a line is    mx + b    so:
var m = (y2-y1) / (x2-x1); // slope is rise over run
var b = y1 - (m * x1); // with y = mx + b i just solve for b

var intersectionPts = ds_list_create();

// Now we go through all 4 'walls' of the rectagle, solve for the x or y of that 'wall' and see if its in bounds (if it is then it's the correct coords)
// ---------- RIGHT WALL
var dy = m * rx2 + b;
if( dy > ry1 && dy < ry2 && x2 > rx2) {
	ds_list_add(intersectionPts, [rx2, dy]);
}
// ---------- LEFT WALL
var dy = m * rx1 + b;
if( dy > ry1 && dy < ry2 && x2 < rx1) {
	ds_list_add(intersectionPts, [rx1, dy]);
}
// ---------- TOP WALL ( for these walls we solve for x instead so we have the formula x = (y-b)/m
// we also have to do something special if the slope is infinite
var dx = (ry1 - b) / m;
if( x1-x2 == 0 ) dx = x2;
if( dx > rx1 && dx < rx2 && y2 < ry1) {
	ds_list_add(intersectionPts, [dx, ry1]);
}
// ---------- BOTTOM WALL
var dx = (ry2 - b) / m;
if( x1-x2 == 0 ) dx = x2;
if( dx > rx1 && dx < rx2 && y2 > ry2) {
	ds_list_add(intersectionPts, [dx, ry2]);
}
return intersectionPts;