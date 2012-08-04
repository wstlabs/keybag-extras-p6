use v6;
BEGIN { @*INC.unshift: './lib' }
use KeyBag::Deco;
use Test;
plan *;

sub test_div (%h, %g, $n)  {
    my $h = keybag(%h);
    my $g = keybag(%g).div($n);
    say "h = ", $h;
    say "g = ", $g;
    ok $h eqv $g, "$h = $g / $n";
}

test_div 
    { r => 1 },
    { r => 2 },
    2
;


# test_div ( "r", "r2", 2 );


