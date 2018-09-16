///light_set_multiscale(xs, ys)
/// @param xs
/// @param ys
/*
This will scale the light sprite.
Notice that this will not change the size of the surface the light is drawn on, only the sprite itself.
size: Scale of the light sprite.
*/

if !_light_is_multiscaled exit;

_light_xscale = argument0
_light_yscale = argument1

var ls = max(_light_xscale, _light_yscale)
_light_max_dist = max(sprite_get_width(_light_sprite),
                      sprite_get_height(_light_sprite)) * ls