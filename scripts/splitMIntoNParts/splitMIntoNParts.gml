/// splitMIntoNParts(m,n)
/// @param m
/// @param n

var m = argument[0];
var n = argument[1];

// generate n random numbers
var rands = [];
var sum = 0;
for (var i = 0; i < n; i ++) {
	randomize();
	var rand = random_range(1,100);
	rands[i] = rand;
	sum += rand;
}

for (var i = 0; i < n; i++) {
	var rand = rands[i];
	rand = (rand / sum)*m;
	rands[i] = rand;
}

return rands;