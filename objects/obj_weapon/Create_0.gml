limb = global.limb;
limbKey = limb.limbKey;
owner = limb.owner;
limbItem = limb.limbItem;
persistent = limb.persistent;
fireOffsetX = noone; fireOffsetY = noone; // fire offset for torch

spriteString = "spr_"+owner.spriteString+"_"+limbItem.spriteName;
//sprite_index = asset_get_index(spriteString);
layer = owner.layer;
//depth = layer_get_depth(layer) - 5000;

if limbKey == "l" {
	image_yscale = -1;
}

// particle system for elemental effects
refreshParticles = false;
system = part_system_create();
part_system_depth(system,layer_get_depth(owner.layer));
emitter = part_emitter_create(system);
weaponParticles = [noone, noone, noone, noone, noone];
weaponParticlesNums = [noone, noone, noone, noone, noone];
// particle system for torch
torchParticle1 = noone;
torchParticle2 = noone;
torchSystem1 = part_system_create();
torchSystem2 = part_system_create();
torchEmitter1 = part_emitter_create(torchSystem1);
torchEmitter2 = part_emitter_create(torchSystem2);
torchAudioEmitter = audio_emitter_create();
audio_emitter_gain(torchAudioEmitter,0);
audio_play_sound_on(torchAudioEmitter,snd_torch_loop,1,0);
// torchlight stuff
torchLightRadius = noone;
lightRadiusColor = C_FIRELIGHT; 
lightRadiusAlpha = .5;
lightRadiusScale = 1;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;

updateWeaponParticles(limbItem);
