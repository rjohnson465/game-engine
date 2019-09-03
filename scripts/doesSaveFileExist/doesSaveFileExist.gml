/// doesSaveFileExist(fileName)
/// @param fileName

/// return whether or not a given filename exists as a save game

var fn = argument[0];

return file_exists(fn + ".sav");