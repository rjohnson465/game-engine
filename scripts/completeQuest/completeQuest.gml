/// completeQuest(quest, gainXp*)
/// @param quest
/// @param gainXp* optional boolean flag to get quest xp reward, used in testing
var quest = argument[0];
var doGainXp = true;
if argument_count > 1 {
	doGainXp = argument[1];
}

if !quest.currentQuestStep.isRewardStep || quest.isFinished exit;

quest.currentQuestStep.status = QuestStepStatus.Completed;
// decrement how many quests the player has at the reward step (pending completion)
global.player.questsAtRewardStepCount--;

if doGainXp {
	gainXp(quest.xpReward);
}
audio_play_sound(snd_ui_quest_complete,1,0);
var itemsString = "";
for (var i = 0; i < ds_list_size(quest.rewardItems); i++) {
	var item = ds_list_find_value(quest.rewardItems,i);	
	itemsString += item.name;
	
	addItemToInventory(item);
	if i < ds_list_size(quest.rewardItems)-1 {
		itemsString += ", ";
	}
}

ds_list_clear(quest.rewardItems);

var s = "Quest Complete: " + quest.name;
//alert("Quest Complete: " + quest.name,c_lime);
if quest.xpReward > 0 {
	//alert("+" + string(quest.xpReward) + " XP",c_lime,150);
	s += "\n+" + string(quest.xpReward) + " XP";
}
if itemsString != "" {
	//alert(itemsString + " added to inventory",c_lime,150);
	s += "\n" + itemsString + " added to inventory";
}
alert(s,c_lime,150);

quest.isFinished = true;
quest.isRewardClaimed = true;

with global.ui {
	if isShowingMenus {
		showHideSkills();
	}
}

raiseEvent(EV_QUEST_COMPLETED, [quest]);