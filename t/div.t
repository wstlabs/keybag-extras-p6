use v6;
BEGIN { @*INC.unshift: './lib' }
use KeyBag::Deco;
use KeyBag::Ops;
use Test;
plan *;

sub test_div (%h, %g, $n)  {
    my $h = keybag(%h);
    my $g = keybag(%g);
    # say "h = ", $h;
    # say "g = ", $g;
    ok $h eqv $g / $n, "{$h.perl} = {$g.perl} / $n";
}

test_div { r => 1 }, { r => 2 }, 2 ;
test_div { r => 0 }, { r => 1 }, 2 ;
test_div { r => 1 }, { r => 3 }, 2 ;
test_div { r => 1 }, { r => 1 }, 1 ; 
test_div { r => 0 }, { r => 0 }, 1 ;
test_div { r => 0 }, { r => 0 }, 3 ;

# 
# fail cases
#
{
    my $y;
    my $x = keybag({ r => 1 });
    dies_ok { $y = $x.div(0) }, "x / 0"; 
}

