// loot item
if isBeingLooted && !global.isReadingTutorial {
	lootItem(selectedItem,id);
	updatePersistentElementProperty(id,"isLooted",true);
}