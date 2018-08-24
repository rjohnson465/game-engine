/// isFading()
/// static function -- returns whether there is any fade effect going on (wish, room change, etc)
with obj_fade {
	return instance_count > 0;
}