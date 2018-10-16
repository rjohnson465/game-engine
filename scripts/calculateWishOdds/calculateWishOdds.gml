/// calculateWishOdds(proposal, successAmount)
/// @param proposal
/// @param sucessAmount
var proposal = argument[0];
var sa = argument[1];

// TODO this is wrong, Devin pls help
var cx = (MATH_E / sa) * proposal;
var odds = -(exp(-(cx))-1)+0.01;

return odds*100;