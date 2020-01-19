global.ownerNpcName = "David";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Dybukks";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "The Abominable Snowman’s Dark Winter magic has disturbed our dead. Spirits beyond the veil, dybukks, have risen, and now haunt the tundra and clayfields just outside this village.";
cs.sound = snd_conv_david_dybukks_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Dybukks are malevolent spirits, magical and mysterious, and resistant to physical attacks.  Though, it’s said they are vulnerable to magic.";
cs.sound = snd_conv_david_dybukks_david_2;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Thankfully, we’ve managed to keep the dybukks from infecting our citizens, though many golems that roam beyond this village have been possessed.";
cs.sound = snd_conv_david_dybukks_david_3;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);


return c1;