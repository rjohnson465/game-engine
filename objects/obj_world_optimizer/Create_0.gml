// every x steps, deactivate solid enviornment objects that are far away out of the view
#macro DEACTIVATION_STEPS_DEFAULT 15;
deactivationSteps = DEACTIVATION_STEPS_DEFAULT;
deactivationBorder = 500;
alarm[5] = deactivationSteps;

persistent = true;