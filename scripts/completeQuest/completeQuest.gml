/// completeQuest(quest)
/// @param quest
var quest = argument[0];

gainXp(quest.xpReward);
var itemsString = "";
for (var i = 0; i < ds_list_size(quest.rewardItems); i++) {
	var item = ds_list_find_value(quest.rewardItems,i);
	addItemToInventory(item);
	itemsString += item.name;
	if i < ds_list_size(quest.rewardItems)-1 {
		itemsString += ", ";
	}
}

alert("Quest Complete: " + quest.name,c_lime);
if quest.xpReward > 0 {
	alert("+" + string(quest.xpReward) + " XP",c_lime);
}
if itemsString != "" {
	alert(itemsString + " added to inventory",c_lime);
}

quest.isFinished = true;
with global.ui {
	showHideSkills();
}