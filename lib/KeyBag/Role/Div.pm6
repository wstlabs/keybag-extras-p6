use v6;

#
# a simple (integer-centric) div op.
#
#    multi method div ()  { Nil }

role KeyBag::Role::Div  {
    multi method div ($n)  {
        self.new(
            hash
            map -> $k, $v {
                $k => $v / $n
            }, self.hash.kv
        ) 
    }
}

