/// makeKey(keyName, keySpriteName, keySpriteIndex)
/// @param keyName
/// @param keySpriteName
/// @param keySpriteIndex
/// @param keyDescription

var name = argument[0];
var sname = argument[1];
var si = argument[2];
var d = argument[3];

global.keyName = name;
global.keySpriteName = sname;
global.keySpriteIndex = si;
global.keyDescription = d;
return instance_create_depth(x,y,1,obj_item_key);
