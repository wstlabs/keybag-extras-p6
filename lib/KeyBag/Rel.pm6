use v6;
role KeyBag::Rel  {
}

=begin END


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


