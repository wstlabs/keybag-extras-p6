An extension of the core KeyBag class in Perl 6, providing some functionality that is currently (August, 2012) either underimplemented (or perhaps buggy) in both Rakudo and Niecza.  It also provides some non-standard behaviors such as cartesian product (×), dot product (∙) and scalar division (/). 

In Perl 6, a ```KeyBag```, basically corresponds to the what computer scientists would call a Multiset: 

  https://en.wikipedia.org/wiki/Multiset

And the Perl 6 specification was first (loosely) stated in Synopsis 32:
  
  http://perlcabal.org/syn/S32/Containers.html

Intuitively it behaves pretty much like a standard Hash with values constrained to be positive (nonzero) integers, with unicode operators (like '∈', '⊂', etc) for the usual set theoretic relations, as well as some multi-set specific operations, like multi-set sum (⊎) thrown in.  

It was the absence of working unicode ops in particular (as well some apparently broken relations in the Rakudo implementation) which drove me to create this alternate version.  I chose to create it as an extension ```KeyBag::Deco``` (as in "decorated"), rather than to subsume the KeyBag namespace itself, both for reliability purposes and to avoid any impression that the two classes are interchangeable (they're 

### Usage 

Generally the two classes are interface-compatible; the constructor inherits directly, so you just need to
```
use KeyBag::Deco
my $bag = KeyBag::Deco(...whatever args...)
```
and you'll be on your way.  However, to use the uncode ops you'll need to include a separate package, ```KeyBag::Ops``` (having things this way makes it easier to "toggle" the newer unicode ops in and out of existence, should one which to compare with what's provided by whatever compiler you're using). 


