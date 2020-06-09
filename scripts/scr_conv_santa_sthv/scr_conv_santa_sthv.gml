global.ownerNpcName = "Santa";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isUrgent = true;
c1.isRepeatable = false;
c1.name = "Saving the Holidays (Snowman Killed)";

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Wow you’re alive. Pay up, David.";
cs.sound = snd_conv_santa_sthv_santa_1;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "We’ve really gotta stop gambling.";
cs.sound = snd_conv_santa_sthv_david_1;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Speaking of, can you vouch for me now to get into the olive branch casino? I killed the abominable snowman.";
cs.sound = snd_conv_santa_sthv_gary_1;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Ah, yes. We heard his screams. We weren’t sure if you were winning or it was gleefully exclaiming as it picked the flesh from your bones.";
cs.sound = snd_conv_santa_sthv_santa_2;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Very cool, now the voucher?";
cs.sound = snd_conv_santa_sthv_gary_2;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Of course, dear Gary, of course. We actually co-wrote one, while you were gone, in the event you survived.";
cs.sound = snd_conv_santa_sthv_david_2;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Here, take it!";
cs.sound = snd_conv_santa_sthv_santa_3;
cs.speaker = obj_npc_santa;
cs.func = scr_quest_sth_getvoucher;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oh wow, good to see you guys getting along.";
cs.sound = snd_conv_santa_sthv_gary_3;
cs.speaker = obj_player;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yes, we decided to put aside our differences, at least, until the next holiday season. Which is, of course, right now!";
cs.sound = snd_conv_santa_sthv_santa_4;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Oy vey, I nearly forgot. Good luck Gary, we best be off now! Visit anytime! Oh and Santa?";
cs.sound = snd_conv_santa_sthv_david_3;
cs.speaker = obj_npc_david;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "Yeah?";
cs.sound = snd_conv_santa_sthv_santa_5;
cs.speaker = obj_npc_santa;
ds_list_add(c1.steps,cs);

var cs = instance_create_depth(x,y,1,obj_conversation_step_parent);
cs.text = "I hope you stub every one of your toes on your stupid sleigh.";
cs.sound = snd_conv_santa_sthv_david_4;
cs.speaker = obj_npc_david;
cs.func = completeQuest;
cs.funcParam1 = obj_quest_savingtheholidays;
ds_list_add(c1.steps,cs);

return c1;