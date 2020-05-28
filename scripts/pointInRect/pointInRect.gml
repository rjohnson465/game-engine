/// pointInRect(px, py, rlx, rly, rbx, rby)
/// @param px
/// @param py
/// @param rlx
/// @param rly
/// @param rbx
/// @param rby

var px = argument[0];
var py = argument[1];
var rlx = argument[2];
var rly = argument[3];
var rbx = argument[4];
var rby = argument[5];

var isInRect = pointInPolygon([px, py], [[rlx, rly], [rbx, rly], [rbx, rby], [rlx, rby]]);

return isInRect;