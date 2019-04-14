/// makeGemPieces(gem,condition)
/// @param gem
/// @param condition macro value

var gem = argument[0];
var condition = argument[1];

global.gemPiecesCondition = condition;
return instance_create_depth(x,y,1,gem);