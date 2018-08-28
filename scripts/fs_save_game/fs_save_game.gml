/// saveGame

var save_data = ds_map_create();
var filename = global.gameManager.currentSaveFile;
// save player info
var playerDataMap = fs_save_player();
ds_map_add_map(save_data,"Player",playerDataMap);

// save fountain info
var roomDataMap = fs_save_roomdata();
ds_map_add_map(save_data,"RoomData",roomDataMap);

// save enemy info
var enemyDataMap = fs_save_enemies();
ds_map_add_map(save_data,"Enemies",enemyDataMap);

// save inventory items
var inventoryDataMap = fs_save_inventory();
ds_map_add_map(save_data,"Inventory",inventoryDataMap);

// save skills data
var skillsDataMap = fs_save_skills();
ds_map_add_map(save_data,"Skills",skillsDataMap);

// save quests data 
var questsDataMap = fs_save_quests();
ds_map_add_map(save_data,"Quests",questsDataMap);

// save npc data
var npcsDataMap = fs_save_npcs();
ds_map_add_map(save_data,"Npcs",npcsDataMap);

// save to file name
ds_map_secure_save(save_data,filename);

ds_map_destroy(playerDataMap); playerDataMap = -1;
ds_map_destroy(enemyDataMap); enemyDataMap = -1;
ds_map_destroy(inventoryDataMap); inventoryDataMap = -1;
ds_map_destroy(skillsDataMap); skillsDataMap = -1;
ds_map_destroy(questsDataMap); questsDataMap = -1;
ds_map_destroy(npcsDataMap); npcsDataMap = -1;
// destroying roomDataMap or save_data results in a stack overflow -- why?
