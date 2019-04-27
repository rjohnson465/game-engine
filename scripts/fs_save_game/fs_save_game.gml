/// saveGame

var save_data = ds_map_create();
var filename = global.gameManager.currentSaveFile;
if filename = noone filename = "Game.sav";
global.gameManager.currentSaveFile = filename;

// save player info
var playerDataMap = fs_save_player(); // CLEAN
ds_map_add_map(save_data,"Player",playerDataMap);



// save roomdata info
var roomDataMap = fs_save_roomdata(); // CLEAN
ds_map_add_map(save_data,"RoomData",roomDataMap);



// save enemy info
var enemyDataMap = fs_save_enemies(); // CLEAN
ds_map_add_map(save_data,"Enemies",enemyDataMap);


// save inventory items
var inventoryDataMap = fs_save_inventory(); // CLEAN
ds_map_add_map(save_data,"Inventory",inventoryDataMap);

// save skills data
var skillsDataMap = fs_save_skills(); // CLEAN
ds_map_add_map(save_data,"Skills",skillsDataMap);

// save quests data 
var questsDataMap = fs_save_quests(); // CLEAN
ds_map_add_map(save_data,"Quests",questsDataMap);

// save npc data
var npcsDataMap = fs_save_npcs();
ds_map_add_map(save_data,"Npcs",npcsDataMap);

// save to file name
ds_map_secure_save(save_data,filename);

ds_map_destroy(save_data); save_data = -1;


var a = 1;

var b = 170;

var c = 3;

