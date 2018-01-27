ui = global.ui;
global.inventory = id;

filtersHeight = 30;
filtersWidth = 30;
width = ui.menusWidth/3;
topLeftY = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight;
topLeftX = MENUS_TOPLEFT_X;
bottomRightX = MENUS_TOPLEFT_X+width; // inv shares screen with 2 other evenly sized menus
bottomRightY = MENUS_BOTTOMRIGHT_Y;

height = MENUS_BOTTOMRIGHT_Y-topLeftY;

menuButtonCoordinates = ds_map_create();
enum InventoryFilters {
	None,
	Melee,
	Magic,
	Ranged,
	Shields,
	Other
}
filter = InventoryFilters.None;
filterSprites = ds_map_create();
ds_map_add(filterSprites,InventoryFilters.None,spr_filter_none);
ds_map_add(filterSprites,InventoryFilters.Melee,spr_filter_melee);
ds_map_add(filterSprites,InventoryFilters.Ranged,spr_filter_ranged);
ds_map_add(filterSprites,InventoryFilters.Shields,spr_filter_shields);
ds_map_add(filterSprites,InventoryFilters.Magic,spr_filter_magic);

// add filter coordinates
var currentFilter = ds_map_find_first(filterSprites);
for (var i = 0; i < ds_map_size(filterSprites); i++) {
	var spr = ds_map_find_value(filterSprites,currentFilter);
	if filter == currentFilter {
		draw_sprite(spr,1,topLeftX+(i*filtersWidth),topLeftY);
	} else {
		draw_sprite_ext(spr,1,topLeftX+(i*filtersWidth),topLeftY,1,1,0,c_gray,.75);
	}
	
	ds_map_replace(menuButtonCoordinates,currentFilter,[topLeftX+(i*filtersWidth),topLeftY,topLeftX+(i*filtersWidth)+filtersWidth,topLeftY+filtersHeight]);
	
	currentFilter = ds_map_find_next(filterSprites,currentFilter);
}	
pressedFilter = noone;

// inventory itself slots / dimensions
slotWidth = sprite_get_width(spr_item_slot);
slotHeight = sprite_get_height(spr_item_slot);
invWidth = 5*slotWidth;
invHeight = 4*slotHeight;
invTopLeftX = topLeftX;
invTopLeftY = topLeftY+filtersHeight;
invBottomRightX = invTopLeftX+invWidth; // TODO this doesn't account for scroll bar width, does this matter?
invBottomRightY = invTopLeftY+invHeight;

// selected item / item description box
selectedItem = noone;
itemDescriptionTopLeftX = topLeftX;
itemDescriptionTopLeftY = topLeftY+filtersHeight+invHeight;
itemDescriptionBottomRightX = topLeftX+width;
itemDescriptionBottomRightY = MENUS_BOTTOMRIGHT_Y;
itemDescriptionHandleHeight = 20;
itemDescriptionCol1X = itemDescriptionTopLeftX;
itemDescriptionCol2X = itemDescriptionTopLeftX+(.5*width);
itemDescriptionColY = itemDescriptionTopLeftY+itemDescriptionHandleHeight;


// scroll stuff
scrollLevel = 0; // display items 0 - 14
scrollSpriteWidth = sprite_get_width(spr_scrollarrow);
scrollSpriteHeight = sprite_get_height(spr_scrollarrow);
scrollBarTopLeftX = topLeftX+invWidth;
scrollBarTopLeftY = topLeftY+filtersHeight;
scrollBarBottomRightX = topLeftX+width;
scrollBarBottomRightY = scrollBarTopLeftY+invHeight;
scrollBarWidth = scrollBarBottomRightX - scrollBarTopLeftX;
// scroll button up
var scrollButtonScale = scrollBarWidth / scrollSpriteWidth;
scrollButtonUpTopLeftX = scrollBarTopLeftX;
scrollButtonUpTopLeftY = scrollBarTopLeftY;//+(scrollSpriteHeight*scrollButtonScale);
scrollButtonUpBottomRightX = scrollButtonUpTopLeftX+(scrollSpriteWidth*scrollButtonScale);
scrollButtonUpBottomRightY = scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale);
// scroll button down
scrollButtonDownTopLeftX = scrollBarTopLeftX;
scrollButtonDownTopLeftY = scrollBarBottomRightY-(scrollSpriteHeight*scrollButtonScale);
scrollButtonDownBottomRightX = scrollButtonDownTopLeftX+(scrollSpriteWidth*scrollButtonScale);
scrollButtonDownBottomRightY = scrollBarBottomRightY;


ds_map_add(menuButtonCoordinates,"InventoryScrollUp",[scrollButtonUpTopLeftX,scrollButtonUpTopLeftY,scrollButtonUpBottomRightX,scrollButtonUpBottomRightY]);
ds_map_add(menuButtonCoordinates,"InventoryScrollDown", [scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonDownBottomRightX,scrollButtonDownBottomRightY]);

isScrollUpPressed = false;
isScrollDownPressed = false;


