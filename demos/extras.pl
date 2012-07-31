use v6;
BEGIN { @*INC.unshift: './lib' }
use KeyBag::Extras;

my $b = KeyBag.new({ a => 2, b => 3, c => -1 })
    but KeyBag::Dist;

say $b;
$b<x> = 5;
$b<y> = 0;
say $b.dist;


$b<z> = -1; 
say $b.dist; # fails



