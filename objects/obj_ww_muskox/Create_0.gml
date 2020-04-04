event_inherited();
isFed = false;

origLayer = layer;

key = fs_generate_key();

neverDeactivate = true;
stopsAttacks = false;

randomize();
// alarm for wandering
alarm[0] = random_range(0, 120);
wanders = true;

mooSounds = [snd_muskox_moo_1, snd_muskox_moo_2];
// alarm for mooing
alarm[1] = random_range(300, 450);

facingDirection = random_range(0, 360);

state = CombatantStates.Idle;

normalSpeed = 2;

system = part_system_create();
emitter = part_emitter_create(system);
particle = part_type_create();
part_type_sprite(particle, spr_particle_heart, 0, 0, 0);
part_type_color2(particle, c_red, c_silver);
part_type_direction(particle, 45, 135, 0, 1);
part_type_life(particle, 30, 60);
part_type_size(particle, .2, .25, 0, 0);
part_type_alpha2(particle, .65, .2);
part_type_speed(particle, .2, .3, 0, 0);
