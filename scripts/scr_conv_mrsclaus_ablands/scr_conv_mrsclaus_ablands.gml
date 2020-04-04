global.ownerNpcName = "Mrs. Claus";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = false;
c1.isRepeatable = true;
c1.name = "Abominable Lands";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "If you keep going south from here, you’ll soon reach the Abominable Lands, home of the Abominable Snowman and his cruel minions.";
cs.sound = snd_conv_mrsclaus_ablands_mrsclaus_1;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "His minions were once fairies, twisted by his Dark Winter Magic. They are made of rock and frost crystals, know Abominable magic, and their very touch is chilling.";
cs.sound = snd_conv_mrsclaus_ablands_mrsclaus_2;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I’ve never seen the Abominable Snowman myself, but I’ve heard his roars in the night. It’s enough to turn my blood to ice. If you seek to kill him, I recommend you try fire.";
cs.sound = snd_conv_mrsclaus_ablands_mrsclaus_3;
cs.speaker = obj_npc_mrsclaus;
ds_list_add(c1.steps,cs);

return c1;