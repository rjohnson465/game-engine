event_inherited();

var floorNum = getLayerFloorNumber(owner.layer);
light_destroy_layer(floorNum, id);

if beamHitLight != noone {
	instance_destroy(beamHitLight); beamHitLight = noone;
}