use v6;
use KeyBag::Clone;
use KeyBag::Cross;
use KeyBag::Dist;
use KeyBag::Rel;
use KeyBag::Dot;

#
# a "decorated" KeyBag extension providing some functionality that is
# currently (2012.07) either un- or partially implemented in rakudo / niecza.
#
# note that our interface ends up being somewhat different, and in any
# case will probably break once official implementations become available. 
# but by then it will hopefully be obsolete, also.
#
class KeyBag::Deco
is    KeyBag
does  KeyBag::Clone
does  KeyBag::Cross
does  KeyBag::Dist
does  KeyBag::Rel
does  KeyBag::Dot {};

multi sub infix:<∈>(   Any $a, KeyBag $x --> Bool) is export {  $x.exists($a) }
multi sub infix:<∉>(   Any $a, KeyBag $x --> Bool) is export { !$x.exists($a) }
multi sub infix:<∋>(KeyBag $x,    Any $a --> Bool) is export {  $x.exists($a) }
multi sub infix:<∌>(KeyBag $x,    Any $a --> Bool) is export { !$x.exists($a) }

multi sub infix:<⊂>(KeyBag $x, KeyBag $y --> Bool) is export {  $y.contains($x) }
multi sub infix:<⊃>(KeyBag $x, KeyBag $y --> Bool) is export {  $x.contains($y) }
multi sub infix:<⊄>(KeyBag $x, KeyBag $y --> Bool) is export { !$y.contains($x) }
multi sub infix:<⊅>(KeyBag $x, KeyBag $y --> Bool) is export { !$x.contains($y) }

multi sub infix:<⊆>(KeyBag $x, KeyBag $y --> Bool) is export {  $y.contains-or-equals($x) }
multi sub infix:<⊇>(KeyBag $x, KeyBag $y --> Bool) is export {  $x.contains-or-equals($y) }
multi sub infix:<⊈>(KeyBag $x, KeyBag $y --> Bool) is export { !$y.contains-or-equals($x) }
multi sub infix:<⊉>(KeyBag $x, KeyBag $y --> Bool) is export { !$x.contains-or-equals($y) }

multi sub infix:<∩> (KeyBag $x, KeyBag $y --> KeyBag) is export {  $x.inter($y) }
multi sub infix:<∪> (KeyBag $x, KeyBag $y --> KeyBag) is export {  $x.union($y) }
multi sub infix:<∖> (KeyBag $x,    Any $y --> KeyBag) is export {  $x.minus($y) }
multi sub infix:<⊎> (KeyBag $x,    Any $y --> KeyBag) is export {  $x.sum($y) }

multi sub infix:<eqv> (KeyBag $x, KeyBag $y --> Bool) is export {  $x.equiv($y) }
multi sub infix:<∙>   (KeyBag $x, Any $y)             is export {  $x.dot($y) }       # dot product
multi sub infix:<×>   (KeyBag $x, KeyBag $y)          is export {  $x.cross($y) }     # cartesian product

# finally, some ugly, but servicable in-place operators
multi sub infix:<∖=> (KeyBag $x, Any $y --> KeyBag) is export {  $x.minus-in-place($y) }
multi sub infix:<⊎=> (KeyBag $x, Any $y --> KeyBag) is export {  $x.sum-in-place($y) }

sub keybag(*@a) is export {
    KeyBag::Deco.new(|@a);
}

=begin END

multi sub infix:<> 

#
# reference list of set ops, derived largely from
#
#   http://www.alanwood.net/unicode/mathematical_operators.html
#
# this list appears to be comprehensive, but it does contain a few bugs -- 
# notably, what it calls "multiset-union" (U+228E) should really be "multiset-diff".
#
# there are also a few others, like "neither-subet-no-superset" which we're
# just skipping, for the time being, but which we can always pull up later.
#
# a couple of other caveats:
#
#   - there is no "multiset-diff"; "set-diff" DWYM here. 
#   - we are using "large" element-of symbols defined in Wood's list; 
#     there are also these "small" element-of symbols, but we're ignoring
#     those.
#

00D7 : 0215 = × =>  cartesian-product
2208 : 8712 = ∈ =>  contains-as-member (R)
2209 : 8713 = ∉ => !contains-as-member (R)
220B : 8715 = ∋ =>  contains-as-member (L)
220C : 8716 = ∌ => !contains-as-member (L)
2216 : 8726 = ∖ =>  set-diff
2219 : 8729 = ∙ => interpunct
2229 : 8745 = ∩ =>  set-inter
222A : 8746 = ∪ =>  set-union
2282 : 8834 = ⊂ =>  is-subset-of
2283 : 8835 = ⊃ =>  is-superset-of
2284 : 8836 = ⊄ => !is-subset-of
2285 : 8837 = ⊅ => !is-superset-of
2286 : 8838 = ⊆ =>  is-subset-of-or-equal-to
2287 : 8839 = ⊇ =>  is-superset-of-or-equal-to
2288 : 8840 = ⊈ => !is-subset-or-equal
2289 : 8841 = ⊉ => !is-superset-or-equal
228E : 8846 = ⊎ =>  multiset-sum

#
# paste from lib/CORE.setting in niecza, for inspirational purposes only. 
#
multi sub infix:<∩>(Baggy $a, Any $b --> Bag) { $a ∩ bag($b) }
multi sub infix:<∩>(Any $a, Baggy $b --> Bag) { bag($a) ∩ $b }
multi sub infix:<∩>(Baggy $a, Baggy $b --> Bag) { bag((set($a) ∪ set($b)).map({ ; $_ => $a{$_} min $b{$_} })) }

proto sub infix:<⊍>($, $ --> Bag) is equiv(&infix:<X>) {*}
multi sub infix:<⊍>(Any $a, Any $b --> Bag) { bag($a) ⊍ bag($b) }
multi sub infix:<⊍>(Bag $a, Bag $b --> Bag) { bag((set($a) ∪ set($b)).map({ ; $_ => $a{$_} * $b{$_} })) }
only  sub infix:<(.)>($a, $b --> Bag) is equiv(&infix:<X>) { $a ⊍ $b }

proto sub infix:<⊎>($, $ --> Bag) is equiv(&infix:<X>) {*}
multi sub infix:<⊎>(Any $a, Any $b --> Bag) { bag($a) ⊎ bag($b) }
multi sub infix:<⊎>(Bag $a, Bag $b --> Bag) { bag((set($a) ∪ set($b)).map({ ; $_ => $a{$_} + $b{$_} })) }
only  sub infix:<(+)>($a, $b --> Bag) is equiv(&infix:<X>) { $a ⊎ $b }

proto sub infix:<≼>($, $ --> Bool) is equiv(&infix:<==>) {*}
multi sub infix:<≼>(Baggy $a, Baggy $b --> Bool) { so all $a.keys.map({ $a{$_} <= $b{$_} }) }

proto sub infix:<≽>($, $ --> Bool) is equiv(&infix:<==>) {*}
multi sub infix:<≽>(Baggy $a, Baggy $b --> Bool) { so all $b.keys.map({ $b{$_} <= $a{$_} }) }



