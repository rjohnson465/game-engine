if !owner.showBuySell {
	instance_destroy(vendorItemsObj,1);
	instance_destroy(playerItemsObj,1);
	instance_destroy(id,1);
}