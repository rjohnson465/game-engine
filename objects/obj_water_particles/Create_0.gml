owner = global.owner;
system = part_system_create();
emitter = part_emitter_create(system);

part1 = part_type_create();
part2 = noone;
isDestroying = false;
ownerTouchingWater = false;