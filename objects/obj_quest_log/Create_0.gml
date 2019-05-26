ui = global.ui;
global.questLog = id;
width = (MENUS_BOTTOMRIGHT_X - MENUS_TOPLEFT_X)/2;
height = (MENUS_BOTTOMRIGHT_Y-MENUS_TOPLEFT_Y)-ui.menusHandleHeight-ui.menuTabsHeight;
handlesHeight = 20;
isActive = false;

// entire quest log area
topLeftX = MENUS_TOPLEFT_X+width;
topLeftY = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight;
bottomRightX = topLeftX+width;
bottomRightY = topLeftY +height;

// active quests pane
aqTopLeftX = topLeftX; aqTopLeftY = topLeftY;
aqBottomRightX = topLeftX+(width/2.5); aqBottomRightY = bottomRightY;

// scrollbar for active quests pane
scrollBarWidth = 14;//sprite_get_width(spr_scrollarrow);
scrollBarTopLeftX = aqBottomRightX-scrollBarWidth;
// var sh = string_height("test");
scrollBarTopLeftY = aqTopLeftY+handlesHeight+1;
scrollBarBottomRightX = aqBottomRightX;
scrollBarBottomRightY = aqBottomRightY;
scrollLevel = 0;

// selected quest details pane
sqTopLeftX = aqBottomRightX; sqTopLeftY = aqTopLeftY;
sqBottomRightX = bottomRightX; sqBottomRightY = bottomRightY;

selectedQuest = noone;
watchedQuest = noone;
lastQuestIndexDisplayed = 0;
questsDisplayedCount = 0;

isShowingCompletedQuests = true;

// this is either all quests, or all non-completed quests
displayedQuests = ds_list_create();
