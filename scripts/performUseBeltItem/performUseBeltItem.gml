/// performUseBeltItem() 
/// use the belt item at the current index
/// must be called by player object

with obj_npc_parent {
	if isInConversation {
		exit;
	}
}

if global.isWishing exit;
if global.isTrading exit;
if global.isInteractingWithNpc exit;
if global.ui.isShowingMenus exit;


if currentBeltItemIndex < 0 exit;
var currentBeltItem = beltItems[currentBeltItemIndex];
// belt item is not found
if currentBeltItem == undefined || currentBeltItem < 0 || !instance_exists(currentBeltItem) {
	alert("No belt item selected!", c_red);
}
// belt item is found and exists
else {
	useItem(currentBeltItem);
}