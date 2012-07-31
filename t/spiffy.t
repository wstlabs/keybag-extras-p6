use v6;
BEGIN { @*INC.unshift: './lib'; }
use Test;
use KeyBag::Spiffy; 
# use KeyBag::Rel;
plan *;

{
    my $x;
    lives_ok { $x = keybag({a => 1}) },  "inst";

     ok  'a' ∈  $x  , " contains-as-member :  a ∈ x  => T";
     ok  'b' ∉  $x  , "!contains-as-member :  b ∉ x  => T ";
     ok  $x  ∋  'a' , " contains-as-member :  x ∋ a  => T";
     ok  $x  ∌  'b' , "!contains-as-member :  x ∌ b  => T";

    nok  'b' ∈  $x  , " contains-as-member :  b ∈ x  => F";
    nok  'a' ∉  $x  , "!contains-as-member :  a ∉ x  => F";
    nok  $x  ∋  'b' , " contains-as-member :  x ∋ b  => F";
    nok  $x  ∌  'a' , "!contains-as-member :  x ∌ a  => F";

}

{
    my ($x,$y);
    lives_ok { $x = keybag({a => 1})         },  "inst x";
    lives_ok { $y = keybag({a => 1, b => 1}) },  "inst y";

     ok $x ⊂ $y, " is-subset-of   :  x ⊂ y  => T";
     ok $y ⊃ $x, " is-superset-of :  y ⊃ x  => T";
     ok $y ⊄ $x, "!is-subset-of   :  y ⊄ x  => T";
     ok $x ⊅ $y, "!is-superset-of :  x ⊅ y  => T";

    nok $y ⊂ $x, " is-subset-of   :  y ⊂ x  => F";
    nok $x ⊃ $y, " is-superset-of :  x ⊃ y  => F";
    nok $x ⊄ $y, "!is-subset-of   :  x ⊄ y  => F";
    nok $y ⊅ $x, "!is-superset-of :  y ⊅ x  => F";

    nok $x ⊂ $x, " is-subset-of   :  x ⊂ x  => F";
    nok $x ⊃ $x, " is-superset-of :  x ⊃ x  => F";
     ok $x ⊄ $x, "!is-subset-of   :  x ⊄ x  => T";
     ok $x ⊅ $x, "!is-superset-of :  x ⊅ x  => T";

     ok $x ⊆ $y, " is-subset-of-or-equal-to   : x ⊆ y  => T";
     ok $y ⊇ $x, " is-superset-of-or-equal-to : x ⊇ x  => T";
     ok $y ⊈ $x, "!is-subset-or-equal-to      : y ⊈ x  => T";
     ok $x ⊉ $y, "!is-superset-of-or-equal-to : x ⊉ y  => T";

    nok $y ⊆ $x, " is-subset-of-or-equal-to   : y ⊆ x  => F";
    nok $x ⊇ $y, " is-superset-of-or-equal-to : x ⊇ y  => F";
    nok $x ⊈ $y, "!is-subset-or-equal-to      : x ⊈ y  => F";
    nok $y ⊉ $x, "!is-superset-of-or-equal-to : y ⊉ x  => F";

     ok $x ⊆ $x, " is-subset-of-or-equal-to   : x ⊆ x  => T";
     ok $x ⊇ $x, " is-superset-of-or-equal-to : x ⊇ x  => T";
    nok $x ⊈ $x, "!is-subset-or-equal-to      : x ⊈ x  => F";
    nok $x ⊉ $x, "!is-superset-of-or-equal-to : x ⊉ x  => F";
}

{
    my ($x,$y,$z,$E);
    lives_ok { $x = keybag({a => 1, b => 1}) },  "inst x";
    lives_ok { $y = keybag({b => 1, c => 1}) },  "inst y";
    lives_ok { $z = keybag({d => 1}) },          "inst z";
    lives_ok { $E = keybag({}) },                "inst e";
    ok ($x ∩ $y) eqv keybag({ b => 1 }), "x ∩ y";
    ok ($x ∩ $z) eqv $E,                 "x ∩ z";
    ok ($x ∩ $x) eqv $x,                 "x ∩ x";
    ok ($x ∩ $E) eqv $E,                 "x ∩ E";
    ok ($x ∪ $y) eqv keybag({ a => 1, b => 1, c => 1}), "x ∪ y"; 
    ok ($y ∪ $x) eqv keybag({ a => 1, b => 1, c => 1}), "y ∪ x"; 
    ok ($x ∪ $E) eqv $x, "x ∪ E"; 
    ok ($E ∪ $x) eqv $x, "E ∪ x"; 
    ok ($x ∖ $y) eqv keybag({ a => 1 }), "x ∖ y";
    ok ($y ∖ $x) eqv keybag({ c => 1 }), "y ∖ x";
    ok ($x ∖ $x) eqv $E, "x ∖ x";
    ok ($x ∖ $E) eqv $x, "x ∖ E";
    ok ($E ∖ $E) eqv $E, "E ∖ E";
    ok ($E ∖ $x) eqv $E, "E ∖ x";
}

# multi-set sum
{
    my %x is ro = {a => 1, b => 1,        }; 
    my %y is ro = {        b => 2, c => 4 };
    my %z is ro = {a => 1, b => 3, c => 4 };
    my $E = keybag({});

    {
        my $x = keybag(%x);
        my $y = keybag(%y);
        my $z = keybag(%z);
        ok $x.sum($y) eqv $z, "x.sum(y)";
        ok $y.sum($x) eqv $z, "y.sum(x)";
        ok ($x ⊎ $y)  eqv $z, "x ⊎ y";
        ok ($y ⊎ $x)  eqv $z, "y ⊎ x";
        ok ($x ⊎ $E)  eqv $x, "x ⊎ E";
        ok ($E ⊎ $x)  eqv $x, "E ⊎ x";
    }
}

# in-place operators
{
    my ($x,$y,$E);
    my %x is ro = {a => 1, b => 1, c => 2, d => 1 }; 
    my %y is ro = {        b => 2, c => 1, e => 1 };
    my %z is ro = {a => 1,         c => 1, d => 1 };         # x - y
    my %w is ro = {a => 1, b => 3, c => 3, d => 1, e => 1 }; # x + y

    {
        my $x = keybag(%x);
        my $y = keybag(%y);
        my $z = keybag(%z);
        my $E = keybag({});
        ok $x ∖= $y eqv $z, "x ∖= y (LHS)";
        ok $x       eqv $z, "x ∖= y (object)";
        ok $y       eqv keybag(%y), "y unmolested";
    }


    {
        my $x = keybag(%x);
        my $y = keybag(%y);
        my $u = keybag(%x);
        my $E = keybag({});
        ok $x ∖= $E eqv $u, "x ∖= x (LHS)";
        ok $x       eqv $u, "x ∖= x (object)";
        ok $E       eqv keybag({}), "E unmolested";
    }

    {
        my $x = keybag(%x);
        my $y = keybag(%y);
        my $w = keybag(%w);
        my $E = keybag({});
        ok $x ⊎= $y eqv $w, "x ⊎= y (LHS)";
        ok $x       eqv $w, "x ⊎= y (object)";
        ok $y       eqv keybag(%y), "y unmolested";
    }
}

{
    my %x is ro = { a => 3,   b => 2,   c => 1 };
    my %w is ro = { a => 1/2, b => 1/3, d => 1/7 };
    my %v is ro = { foo => 1/5 };
    my $x = keybag(%x);
    my $E = keybag({});
    my $r = 13/6;

    is $x.dot(%w), $r,   ".dot - simple product (via method)";
    is $x.dot(%v), 0,    ".dot - non-empty set, disjoint measure";
    is $E.dot(%w), 0,    ".dot -     empty set, non-empty measure";
    is $x.dot({}), 0,    ".dot - non-empty set,      zero measure";
    is $E.dot({}), 0,    ".dot -     empty set,      zero measure";
    is $x.dot(),   Nil,  ".dot - non-empty set, null arg";
    is $E.dot(),   Nil,  ".dot -     empty set, null arg";
    is $x.dot(%w), $r,   ".dot - simple product (via method)";
    is $x ∙ %w,    $r,   "x ∙ w";
}

=begin END

    my %w is ro = {        b => 1,         e => 1 };         # y - x (not used)


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
2288 : 8840 = ⊈ => !is-subset-of-or-equal-to
2289 : 8841 = ⊉ => !is-superset-of-or-equal-to
228E : 8846 = ⊎ =>  multiset-sum

