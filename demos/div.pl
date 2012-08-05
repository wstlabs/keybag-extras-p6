use v6;
BEGIN { @*INC.unshift: './lib'; }
use KeyBag::Deco;
use KeyBag::Ops;


sub look-at ($y,$text)  {
    say "y = ", $y.WHICH, " => {$y.perl} .. ", $text;
}

my $x  = keybag({ a => 1, b => 3 });

{
    look-at($x, "");
    look-at( $x / 2,      '2');
    look-at( $x / 2.Int,  '2.Int');
    look-at( $x / Int(2), 'Int(2)' );
    look-at( $x / 2.Rat,  '2.Rat');
    look-at( $x / Rat(2), 'Rat(2)' );
    look-at( $x / Rat(1), 'Rat(1)' );
    look-at( $x / 2.Real, '2.Real');
    look-at( $x / i,      'i' );
}




