use v6;

class X::KeyBag::Role::Div::Zero
is    Exception {
    has $.k;
    has $.v;
    method message()  {
        "attempted division by zero on k = '$.k', v = '$.v'
    }
}

