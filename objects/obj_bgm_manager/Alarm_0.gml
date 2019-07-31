// when room starts, alarm 0 is set
// alarm 0 handles starting bgm
// we cannot do this on Room Start event exactly, because
// it is possible a boss think its alive when its not (since that is handled in Boss Room Start)
// so we must wait until all instance Room Start events happen, then maybe reset bgm

// stop current bgm (maybe, maybe we should fade it out?) and start new bgm music
alarm[2] = -1;
startBgm(); 