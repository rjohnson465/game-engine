/// pointInPolygon(pt, vs) 
/// @param pt [x,y]
/// @param vs [[x,y], [x,y],...]

var point = argument[0];
var vs = argument[1];

var xx= point[0];
var yy = point[1];

var inside = false;
var j = array_length_1d(vs) - 1;
for (var i = 0; i < array_length_1d(vs); i++) {
	j = i + 1; 
	if j >= array_length_1d(vs) {
		j = 0;
	}
	var ip = vs[i]; var jp = vs[j];
    var xi = ip[0];
	var yi = ip[1];
    var xj = jp[0];
	var yj = jp[1];

    var intersect = ((yi > yy) != (yj > yy))
        && (xx< (xj - xi) * (yy - yi) / (yj - yi) + xi);
    if (intersect) inside = !inside;
}

return inside;