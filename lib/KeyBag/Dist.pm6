use v6;
use X::KeyBag::Dist;

role KeyBag::Dist  {
    method dist()  {
        my $n = self.elems; 
        return Nil unless self.keys > 0 && $n > 0;
        hash map -> $k, $v {
            # XXX we assume, of course, that all item counts are positive. 
            # so as long as there are bugs in the KeyBag class which allow for
            # negative item counts to slip through, we need to trap them here. 
            X::KeyBag::Dist::Negative::Count.new(k => $k, v => $v).throw if $v < 0;
            $k => $v / $n
        }, self.hash.kv
    }
}

