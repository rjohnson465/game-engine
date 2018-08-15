/// getPropertyColorForBuffAmount(buff) 
/// @param buff

var buff = argument[0];

if buff > 0 && buff <= global.basePropModTiers[1] {
	return C_RARITY_FINE;
}
else if buff > global.basePropModTiers[1] && buff <= global.basePropModTiers[2] {
	return C_RARITY_MASTERWORK;
}
else if buff > global.basePropModTiers[2] {
	return C_RARITY_LEGENDARY;
}
else return C_RARITY_NORMAL;