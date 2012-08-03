use v6;

# in which we force our clones to be deep, contrary to the default
# behavior of the .clone() method.  not sure how kosher this is, but
# it does seem to be a practical tweak, for now. 
role KeyBag::Clone  {
    multi method clone ()  { 
        self.new( self.hash )
    }
}

