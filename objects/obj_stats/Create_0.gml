ui = global.ui;
eim = global.equippedItemsManager;

topLeftX = eim.topLeftX+eim.width;
topLeftY = eim.topLeftY;
width = eim.width;
height = eim.height;
bottomRightX = topLeftX + width;
bottomRightY = topLeftY + height;

titleHeight = 0;

// basic stats columns
basicCol1XPictures = topLeftX+1;
basicCol1XText = basicCol1XPictures+20;
basicCol1Width = .5*width;
basicCol2XPictures = topLeftX+basicCol1Width;
basicCol2XText = basicCol2XPictures+20;

// weapons / defenses columns
wdCol1XPictures = basicCol1XPictures;
wdCol1XText = wdCol1XPictures+20;
wdCol1Width = (.5*width);//+70;
wdCol2XPictures = topLeftX+wdCol1Width;
wdCol2XText = wdCol2XPictures+20;