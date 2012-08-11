use v6;

#
# straightforward generation of a hash slice
#
role KeyBag::Role::Slice  {
    multi method slice (@k)  {
        self.new(
            hash 
            map -> $k {
                self.exists($k) ?? 
                    $k => self.at_key($k) 
                !! ()
            }, @k 
        )
    }
}

