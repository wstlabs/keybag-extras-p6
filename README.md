An extension of the core KeyBag class in Perl 6, providing some functionality that is currently (August, 2012) either underimplemented (or perhaps buggy) in both Rakudo and Niecza.  It also provides some non-standard behaviors such as cartesian product (×), dot product (∙) and scalar division (/). 

A "KeyBag", btw, basically corresponds to the what computer scientists would call a Multiset: 

  https://en.wikipedia.org/wiki/Multiset

And the Perl 6 specification is given (or at least loosely sketched) in Synoopsis 32:
  
  http://perlcabal.org/syn/S32/Containers.html

Intuitively it's behaves pretty much like a standard Hash with values constrained to be positive (nonzero) integers, with unicode operators (like '∈', '⊂', etc) for the usual set theoretic relations, as well as some multi-set specific operations, like multi-set sum (⊎) thrown in.  

It was the absence of working unicode ops (as well some apparently broken relations, based on casual inspection) which drove me to create this alternate version.  I chose to create it as an extension KeyBag::Deco (as in "decorated"), rather than to subsume the KeyBag namespace itself, both for reliability purposes and to avoid any impression that the two classes are interchangeable (they're not). 

## Usage ## 

tba
