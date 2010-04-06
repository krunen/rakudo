augment class Mu {
    method Bool { $.defined }

    method item {
        # This is overridden by non-items.
        self;
    }

    multi method notdef() { !self.defined; }

    multi method perl {
        self.WHAT.substr(0, -2) ~ '.new()';
    }
    
    method print() {
        print(self);
    }
    
    method say() {
        say(self);
    }

    method Capture() {
        my %attrs;
        my @mro = self, self.^parents;
        for @mro -> $class {
            for $class.^attributes() -> $attr {
                if $attr.has_accessor {
                    my $name = substr($attr.name, 2);
                    %attrs{$name} //= self."$name"();
                }
            }
        }
        %attrs.Capture()
    }
}
