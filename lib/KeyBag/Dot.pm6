use v6;
role KeyBag::Dot  {

    multi method dot ()  { Nil }
    multi method dot (%u)  {
        return [+] map -> $k, $v {
            %u{$k} ?? $v * %u{$k} !! () 
        }, self.hash.kv
    }

}

=begin END

        say "self = ", self; 
        say "u = ", %u;
        my @a = map -> $k, $v {
            say "k = $k, v = $v";
            %u{$k} ?? $v * %u{$k} !! () 
        }, self.hash.kv;
        say "a = ", @a;

