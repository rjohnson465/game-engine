/// alert(string,color,*length)
/// @param string
/// @param color
/// @param *length

var str = argument[0];
var c = argument[1];
var length = 120;
if argument_count == 3 {
	length = argument[2];
}

global.alertMessage = str;
global.alertMessageColor = c;
global.alertMessageLength = length;
instance_create_depth(x,y,1,obj_alert);