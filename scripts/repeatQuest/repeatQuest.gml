/// repeatQuest(quest)
/// @param quest

var quest = argument[0];

if !quest.isRepeatable exit;

var qoi = quest.object_index;
var qi = ds_list_find_index(global.player.quests,quest);

ds_list_delete(global.player.quests,qi);

instance_destroy(quest,1);

var newQuest = instance_create_depth(x,y,1,qoi);
var newQuest2 = instance_create_depth(x,y,1,qoi);
alert("Quest Restarted: " + newQuest.name,c_yellow);
ds_list_insert(global.player.quests,qi,newQuest);
ds_list_insert(global.player.quests,qi,newQuest2);

ds_list_delete(global.player.quests,ds_list_find_index(global.player.quests,newQuest));
instance_destroy(newQuest,1);

global.questLog.selectedQuest = newQuest2;