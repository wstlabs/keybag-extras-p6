use v6;
BEGIN { @*INC.unshift: './lib' }
use KeyBag::Deco;
use Test;
plan *;

{
    my $x;
    lives_ok { 
        $x = KeyBag::Deco.new({ a => 2, b => 3 })
    }, "valid inst";
    lives_ok { $x<c> = 1 }, "assign";
    is_deeply
        $x.dist, { a => 1/3, b => 1/2, c => 1/6 }
    , "dist";

    my $y;
    lives_ok { 
        # XXX this construction only survives due to a lack of thorough 
        # arg checking in the current (2012.05) rakudo impl.  but it's also 
        # the only way we know at present to force the KB class to accept a 
        # "degenerate" set histo, which we need in order to exercise the
        # fail case below.
        $y = KeyBag::Deco.new({ a => 2, b => 3, c => -1 }) 
    }, "degenerate inst";
    dies_ok { my $dist = $y.dist }, "expected fail on dist()";
}



