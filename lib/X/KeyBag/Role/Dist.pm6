use v6;

class X::KeyBag::Role::Dist::Negative::Count 
is    Exception {
    has $.k;
    has $.v;
    method message()  {
        "invalid (negative) count '$.v' for item '$.k'"
    }
}

