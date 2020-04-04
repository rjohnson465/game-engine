/// questStart(quest, *doPlaySound)
/// @param quest
/// @param *doPlaySound

var questObj = argument[0];
var doPlaySound = true;
if argument_count > 1 {
	doPlaySound = argument[1];
}

// There should only ever be a single instance of a quest
if instance_number(questObj) > 0 exit;

var quest = instance_create_depth(x,y,1,questObj);
quest.currentQuestStep = ds_list_find_value(quest.questSteps,0);
quest.currentQuestStepIndex = 0;
ds_list_add(global.player.quests,quest);

if doPlaySound {
	alert(quest.name + " added to Quest Log",c_yellow);
}

// is this the right sound?
if doPlaySound {
	audio_play_sound(snd_ui_quest_complete_alert, 1, 0);
}