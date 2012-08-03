use v6;

#
# provides a simple dot product operator, naturally extending the 
# usual definition for vectors or ordered tuples.
#
role KeyBag::Role::Dot  {
    multi method dot ()  { Nil }
    multi method dot (%u)  {
        return [+] map -> $k, $v {
            %u{$k} ?? $v * %u{$k} !! () 
        }, self.hash.kv
    }

}

=begin END

