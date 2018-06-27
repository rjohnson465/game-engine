event_inherited();
subType = HandItemTypes.Melee;
weaponType = DAGGER;

// for each attack in chain
numberOfTargets = [1,1,1,1];

handSpriteString = "spr_player_hand_dagger";

weaponSpeed = "Fast";
staggerDuration = 10; // frames
staminaCostArray=[7,7,8,10];
//physicalDamageTypeArray = ["slashing","slashing","piercing"];
attackSounds = [snd_dagger_attack_1, snd_dagger_attack_1, snd_dagger_attack_1, snd_dagger_attack_1];
hitSounds = [snd_hit1, snd_hit1, snd_hit1, snd_hit1];

soundDrop = snd_item_metal;