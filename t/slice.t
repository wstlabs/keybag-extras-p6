use v6;
BEGIN { @*INC.unshift: './lib'; }
use KeyBag::Deco;
use KeyBag::Ops;
use Test;

sub test-slice($bag,@t,%h)  {
    my $s = $bag.slice(@t);
    ok $s.hash eqv %h, "{@t} => {$s.perl}" 
}

{
    my $x = keybag({ a => 3, b => 2, c => 1 });
    test-slice $x, (),      {};
    test-slice $x, <a b>,   {a => 3, b => 2};
    test-slice $x, <a b x>, {a => 3, b => 2};
}




