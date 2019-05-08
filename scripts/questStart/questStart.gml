/// questStart(quest)
/// @param quest

var questObj = argument[0];

// There should only ever be a single instance of a quest
if instance_number(questObj) > 0 exit;

var quest = instance_create_depth(x,y,1,questObj);
quest.currentQuestStep = ds_list_find_value(quest.questSteps,0);
quest.currentQuestStepIndex = 0;
ds_list_add(global.player.quests,quest);
alert(quest.name + " added to Quest Log",c_yellow);