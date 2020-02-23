owner = global.owner;
ownerNpcName = global.ownerNpcName;
name = "";
steps = ds_list_create();
currentStep = noone;
currentSound = noone;
isFinished = false;
isRepeatable = false;
isActive = false;
narrativeState = 0;
isUrgent = false;


// half second delay for when skipping is allowed
CONV_SKIP_DELAY_FRAMES = 15;
skipTimer = CONV_SKIP_DELAY_FRAMES; 
canBeSkipped = false;
alarm[0] = skipTimer;