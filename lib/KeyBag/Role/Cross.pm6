use v6;

#
# WARNING!
# This is an EXTREMELY hack-ish way of doing cartesian products.
#
# The correct way would be to use multi-dimensional hash keys, which are NYI 
# last I checked.  As a workaround, one might think to try using an Any-valued 
# hash, with some container type or another as keys, like in the snippet below.
# But it would still be collapsed in the constructor to the core KeyBag 
# class (which uses a Str(Any) hash internally).
#
# So rather than try to come up with a stable workaround, let's just do the 
# simplest thing which could work for our use case -- just set a comma-separated
# catenation of Str keys as our unidimensional hash key, and then "hope" that 
# nobody tries to do a cross product on a hash containing a comma in one of
# its keys somewhere. 
#

role KeyBag::Role::Cross  {
    multi method cross ()  { Nil }
    multi method cross (KeyBag $b)  {
        self.new(
            hash 
            map -> $ka,$va {
                map -> $kb,$vb {
                    "$ka,$kb" => $va * $vb
                }, $b.hash.kv
            }, self.hash.kv
        )
    }
}


=begin END

    #
    # here's one way we might try to 'fake' a 2-dimensional hash, 
    # absent bona-fide multidimensional keys, and assuming we can 
    # use Any keys -- which we can't do with the current KeyBag 
    # class, presently:
    # 

    my %h{Any};
    for self.hash.kv -> $ka,$va {
        for $b.hash.kv -> $kb,$vb {
            %h{ $ka => $kb } = $va * $vb
        }
    }

