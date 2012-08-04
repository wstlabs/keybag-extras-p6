use v6;

#
# a simple (integer-centric) div op.
#
# XXX find a less brain-dead way to do these coercions, please.
#
role KeyBag::Role::Div  {
    multi method div ()  { Nil }

    multi method div (Int $n)  {
        self.new( hash map -> $k, $v {  $k => ($v / $n).Int  }, self.hash.kv) 
    }

    multi method div (Rat $q)  {
        self.new( hash map -> $k, $v {  $k => ($v / $q).Rat  }, self.hash.kv) 
    }

    multi method div (Any $x)  {
        self.new( hash map -> $k, $v {  $k => $v / $x      }, self.hash.kv) 
    }
}

=begin END

