global.ownerNpcName = "David";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Golems";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Golems are clay constructs that serve my people, sometimes acting as guardians, sometimes just as companions.";
cs.sound = snd_conv_david_golems_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Beyond these village boundaries, however, many golems have been possessed by malicious spirits, which force them to do their wicked bidding.";
cs.sound = snd_conv_david_golems_david_2;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Please, return these possessed golems to the clay they came from. Just about anything other than poison should do the trick, but of course, you’re not daft enough to try and poison clay, right?";
cs.sound = snd_conv_david_golems_david_3;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);


return c1;