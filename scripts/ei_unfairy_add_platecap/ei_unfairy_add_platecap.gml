/// ei_unfairy_add_platecap	

hatSpriteIndex = spr_player_plated_cap;
ds_map_replace(defenses,SLASH,30);
ds_map_replace(defenses,CRUSH,15);
ds_map_replace(defenses,PIERCE,40);

poiseCurrent += 30;
poiseMax += 30;

soundsWhenHit = [snd_metalhit1, snd_metalhit2]; // array of potential "hit" sounds (not "ahhs" or dialogue, just like metal in flesh, metal on metal...)