use v6;
use X::KeyBag::Role::Dist;

#
# an extremely simple role which provdies a probability distribution corresponding 
# to the integer-valued histogram that the multiset object represents.  
#
# XXX we assume, of course, that all item counts are positive.   so as long as 
# there are bugs in the KeyBag class which allow for negative item counts to slip 
# through, we need to trap them in the for loop, below. 
#
role KeyBag::Role::Dist  {
    method dist()  {
        my $n = self.elems; 
        return Nil unless self.keys > 0 && $n > 0;
        hash map -> $k, $v {
            X::KeyBag::Role::Dist::Negative::Count.new(k => $k, v => $v).throw if $v < 0;
            $k => $v / $n
        }, self.hash.kv
    }
}

