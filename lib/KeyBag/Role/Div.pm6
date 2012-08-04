use v6;

#
# a simple (integer-centric) div op.
#
role KeyBag::Role::Div  {
    multi method div ()  { Nil }
    multi method div ($n)  {
        self.new(
            hash
            map -> $k, $v {
                $k => ($v / $n).Int
            }, self.hash.kv
        ) 
    }
}

