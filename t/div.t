use v6;
BEGIN { @*INC.unshift: './lib' }
use KeyBag::Deco;
use Test;
plan *;

sub test_div ($s, $t, $n)  {
    my $a = keybag($s);
    my $b = keybag($t) / $n;
    say "a = ", $a;
    say "b = ", $b;
    ok "$a" eq "$b", "$a = $b / $n";
}

test_div 'r', 'r2', 2; 

# test_div ( "r", "r2", 2 );


