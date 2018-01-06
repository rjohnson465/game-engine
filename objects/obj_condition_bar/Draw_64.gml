// condition outline
var x1 = 100-(.5*64);
var y1 = 100-(.5*64)-20;
var x2 = 100+(.5*64);
var y2 = 100-(.5*64)-15;
draw_set_color(c_white);
draw_rectangle(x1,y1,x2,y2,true);
// current condition percent
var conditionPercent = ds_map_find_value(owner.conditionPercentages,condition);
conditionPercent = conditionPercent / 100;
var x2 = x1 + (64 * conditionPercent);
if (x2 < x1) x2 = x1;
draw_set_color(c_red);
draw_rectangle(x1,y1,x2,y2,false);