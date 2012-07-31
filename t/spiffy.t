use v6;
BEGIN { @*INC.unshift: './lib'; }
use Test;
use KeyBag::Spiffy; 
# use KeyBag::Rel;
plan *;

{
    my $x;
    lives_ok { $x = keybag({a => 1}) },  "inst";

     ok  'a' ∈  $x  , " contains-as-member ∈";
    nok  'b' ∈  $x  , " contains-as-member ∈";

     ok  'b' ∉  $x  , "!contains-as-member ∉";
    nok  'a' ∉  $x  , "!contains-as-member ∉";

     ok  $x  ∋  'a' , " contains-as-member ∋";
    nok  $x  ∋  'b' , " contains-as-member ∋";

     ok  $x  ∌  'b' , "!contains-as-member ∌";
    nok  $x  ∌  'a' , "!contains-as-member ∌";

}

{
    my ($x,$y);
    lives_ok { $x = keybag({a => 1})         },  "inst x";
    lives_ok { $y = keybag({a => 1, b => 1}) },  "inst y";

     ok $x ⊂ $y, " is-subset-of   ⊂";
    nok $y ⊂ $x, " is-subset-of   ⊂";

     ok $y ⊃ $x, " is-superset-of ⊃";
    nok $x ⊃ $y, " is-superset-of ⊃";

     ok $y ⊄ $x, "!is-subset-of   ⊄";
    nok $x ⊄ $y, "!is-subset-of   ⊄";

     ok $x ⊅ $y, "!is-superset-of ⊅";
    nok $y ⊅ $x, "!is-superset-of ⊅";

}



=begin END

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

