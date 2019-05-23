selectedItemFilterAlpha = .5*cos((pi*selectedItemFilterAlphaFrame)/30)+.6; // fluctuate alpha for selected item filter
selectedItemFilterAlphaFrame--;
if selectedItemFilterAlphaFrame <= 0 {
	selectedItemFilterAlphaFrame = 60;
}

if global.inventory.selectedItem > 0 {
	selectedItem = noone;
}