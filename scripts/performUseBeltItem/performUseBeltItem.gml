/// performUseBeltItem() 
/// use the belt item at the current index
/// must be called by player object

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