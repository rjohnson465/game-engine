/// getLayerFloorNumber(layer) 
/// @param layer index
var l = argument0
var layerName = layer_get_name(l);
var layerNum = real(string_copy(layerName,string_length(layerName),1));

return layerNum;