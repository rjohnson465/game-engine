/// calculateWishOdds(proposal, successAmount)
/// @param proposal
/// @param sucessAmount
var proposal = argument[0];
var sa = argument[1];
var percentOfSA = proposal/sa;

// TODO this is wrong, Devin pls help
var odds = -(exp(-(percentOfSA*4.56))-1)+0.01;
if odds == .01 odds = 0;
return odds*100;