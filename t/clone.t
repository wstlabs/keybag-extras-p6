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
    # say "x = ", $x.WHICH, " = ", $x;
    # say "y = ", $y.WHICH, " = ", $y;
    # say "eqv => ", ($x eqv $y);
    isnt $x.WHICH, $y.WHICH,   "distinct";
    ok  $x eqv $y,             "equivalent";
    $y{'b'}++;
    nok $x eqv $y,             "disentangled";
    # say "x = ", $x.WHICH, " = ", $x;
    # say "y = ", $y.WHICH, " = ", $y;
    # say "x eqv y : ", ($x eqv $y);
    # say "x  >= y : ", $x.contains-or-equals($y); 
    # say "y  >= x : ", $y.contains-or-equals($x); 
}

