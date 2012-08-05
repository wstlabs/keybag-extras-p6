use v6;

#
# ugh.  being as 'GLOBAL::infix' isn't supported, 
# currently we don't see how else to shove these lovely operators into the
# global namespace, other than putting them into a little side module to be
#  included separately. 
#

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

multi sub infix:<∩> (KeyBag $x,    Any $y --> KeyBag) is export {  $x.inter($y) }
multi sub infix:<∪> (KeyBag $x, KeyBag $y --> KeyBag) is export {  $x.union($y) }
multi sub infix:<∖> (KeyBag $x,    Any $y --> KeyBag) is export {  $x.minus($y) }
multi sub infix:<⊎> (KeyBag $x,    Any $y --> KeyBag) is export {  $x.sum($y) }

multi sub infix:<eqv> (KeyBag $x, KeyBag $y --> Bool) is export {  $x.equiv($y) }
multi sub infix:<∙>   (KeyBag $x,    Any $y)          is export {  $x.dot($y) }       # dot product
multi sub infix:<×>   (KeyBag $x, KeyBag $y)          is export {  $x.cross($y) }     # cartesian product
multi sub infix:</>   (KeyBag $x,    Any $n)          is export {  $x.div($n) }       # scalar div

# finally some ugly, but servicable in-place operators
multi sub infix:<∖=> (KeyBag $x, Any $y --> KeyBag) is export {  $x.minus-in-place($y) }
multi sub infix:<⊎=> (KeyBag $x, Any $y --> KeyBag) is export {  $x.sum-in-place($y) }

