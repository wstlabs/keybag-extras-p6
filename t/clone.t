use v6;
BEGIN { @*INC.unshift: './lib'; }
use Test;
use KeyBag::Deco; 
use KeyBag::Ops;
plan *;

{
    my ($x,$y);
    lives_ok { $x = keybag({a => 1, b => 2}) },    "inst";
    lives_ok { $y = $x.clone() },                  "clone";
    isnt $x.WHICH, $y.WHICH,   "distinct";
    ok  $x eqv $y,             "equivalent";
    $y{'b'}++;
    nok $x eqv $y,             "disentangled";
}

