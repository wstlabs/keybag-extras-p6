use v6;
use KeyBag::Role::Clone;
use KeyBag::Role::Cross;
use KeyBag::Role::Slice;
use KeyBag::Role::Rel;
use KeyBag::Role::Div;
use KeyBag::Role::Dot;

#
# A "decorated" KeyBag extension providing some functionality that is 
# currently (2012.05) either NYI or partially / buggily implemented in 
# both rakudo & niecza.
#
# Note that our interface ends up being somewhat different from the KeyBag class 
# as currently spec'd, and in any case will probably break once official implementations 
# become available.  but by then it will hopefully be obsolete, also.
#
class KeyBag::Deco
is    KeyBag
does  KeyBag::Role::Clone
does  KeyBag::Role::Cross
does  KeyBag::Role::Slice
does  KeyBag::Role::Rel
does  KeyBag::Role::Div
does  KeyBag::Role::Dot {};

sub keybag(*@a) is export {
    KeyBag::Deco.new(|@a);
}

=begin END

