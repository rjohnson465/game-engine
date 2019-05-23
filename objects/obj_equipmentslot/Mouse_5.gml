if item && instance_exists(item) && item.isUsable {
	with global.player {
		useItem(other.item);
	}
}