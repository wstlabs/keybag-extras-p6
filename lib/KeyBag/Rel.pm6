use v6;
role KeyBag::Rel  {

    # XXX needs unit test
    multi method contains-or-equals (KeyBag $b --> Bool)  {
        for $b.keys -> $k {
            return False unless self.at_key($k) >= $b.at_key($k)
        }
        return True
    }

    # XXX needs unit test
    multi method contains (KeyBag $b --> Bool)  {
        self.elems > $b.elems ?? 
            self.contains-or-equals($b) 
        !! False 
    }

    multi method inter (KeyBag $b --> KeyBag)  {
        self.new(
            hash map -> $k {
                $b.exists($k) ??
                    $k => self.at_key($k) min $b.at_key($k)
                !! ()
            }, self.keys
        )
    }

    multi method union (KeyBag $b --> KeyBag)  {
        self.new(
            hash map -> $k {
                $k => self.at_key($k) max $b.at_key($k)
            }, Set.new(self.keys,$b.keys)
        )
    }

    multi method minus (KeyBag $b --> KeyBag)  {
        self.new(
            hash map -> $k {
                $b.at_key($k) ?? 
                    self.at_key($k) >= $b.at_key($k) ??
                        ( $k => self.at_key($k) - $b.at_key($k) )
                    !! ()
                !!  ( $k => self.at_key($k) )
            }, self.keys 
        )
    }
  
    multi method minus-in-place (KeyBag $b --> KeyBag)  {
        for self.keys -> $k {
            if ($b.exists($k))  {
                self.at_key($k) = 
                    self.at_key($k) >= $b.at_key($k) ?? 
                    self.at_key($k) -  $b.at_key($k) !!  0
            }
        }
        return self
    }

    multi method sum (KeyBag $b --> KeyBag)  {
        self.new(
            hash map -> $k {
                $k => self.at_key($k) + $b.at_key($k)
            }, Set.new(self.keys,$b.keys)
        )
    }

    multi method sum-in-place (KeyBag $b --> KeyBag)  {
        for $b.keys -> $k {
            self.at_key($k) += $b.at_key($k) 
        }
        return self
    }

    # alternate signature support for selected ops
    multi method minus          (Any $x)  { self.minus(          self.new($x) ) }
    multi method minus-in-place (Any $x)  { self.minus-in-place( self.new($x) ) }
    multi method sum            (Any $x)  { self.sum(            self.new($x) ) }
    multi method sum-in-place   (Any $x)  { self.sum-in-place(   self.new($x) ) }

    # XXX would hash eqv be quicker?
    multi method equiv (KeyBag $b --> Bool)  {
        self.contains-or-equals($b)    &&
          $b.contains-or-equals(self)
    }
  
}


=begin END

multi sub infix:<∈>(Any $a, KeyBag $x --> Bool) is export { $x.exists($a) }

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

2208 : 8712 = ∈ =>  contains-as-member (R)
2209 : 8713 = ∉ => !contains-as-member (R)
220B : 8715 = ∋ =>  contains-as-member (L)
220C : 8716 = ∌ => !contains-as-member (L)
2216 : 8726 = ∖ =>  set-diff
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


