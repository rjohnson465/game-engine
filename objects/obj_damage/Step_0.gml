if frame <= totalFrames {
	frame++;
} else instance_destroy(id,false);


if !instance_exists(victim) exit;

if victim.hpRegen > 0 {
	if victim.hp < victim.maxHp {
		healingSustained += victim.hpRegen/40;
	}
}