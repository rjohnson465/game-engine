/// alertQuestUpdate(quest,update,*color,*duration)
/// @param quest instance
/// @param update string
/// @param *color
/// @param *duration

var quest = argument[0];
var msg = argument[1];
var c = c_yellow;
if argument_count >= 3 {
	c = argument[2];
}

if argument_count == 4 {
	alert("Quest update: " + quest.name + "\n" + msg,c,argument[3]);
} 
else {
	alert("Quest update: " + quest.name + "\n" + msg,c);
}