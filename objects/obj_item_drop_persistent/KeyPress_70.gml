// loot item
if isBeingLooted {
	lootItem(selectedItem,id);
	updatePersistentElementProperty(id,"isLooted",true);
}