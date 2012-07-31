use v6;
BEGIN { @*INC.unshift: './lib' }
use KeyBag::Spiffy;

my $b = KeyBag::Spiffy.new({ a => 2, b => 3, c => -1 });

say $b;
$b<x> = 5;
$b<y> = 0;
say $b.dist;


$b<z> = -1; 
say $b.dist; # fails



