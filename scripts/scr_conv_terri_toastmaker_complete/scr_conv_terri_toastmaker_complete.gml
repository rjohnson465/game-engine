
// welcome convo
global.ownerNpcName = "Terri the Toaster";
var c1 = instance_create_depth(x,y,1,obj_conversation_parent);
c1.isRepeatable = false;
c1.name = "ToastMaker (Complete)";
c1.isUrgent = true;

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Ah, yes, bread! Put it in me now.";
c.sound = snd_conv_terri_toastmaker_complete_terri_1;
c.speaker = obj_npc_terri;
c.func = scr_terri_take_bread;
ds_list_add(c1.steps,c);

var c = instance_create_depth(x,y,1,obj_conversation_step_parent);
c.text = "Here, have the toast. You earned it, and maybe more...";
c.sound = snd_conv_terri_toastmaker_complete_terri_2;
c.speaker = obj_npc_terri;
c.func = completeQuest;
c.funcParam1 = obj_quest_toastmaker;
ds_list_add(c1.steps,c);

return c1;