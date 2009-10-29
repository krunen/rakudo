# $Id$


.namespace [ 'Perl6Exception' ]

.sub '' :anon :init :load
    .local pmc p6meta, exceptionproto
    p6meta = get_hll_global ['Perl6Object'], '$!P6META'
    exceptionproto = p6meta.'new_class'('Perl6Exception', 'parent'=>'Any parrot;Exception', 'attr'=>'$!exception', 'name'=>'Exception')
    p6meta.'register'('Exception', 'protoobject'=>exceptionproto)
.end

=head2 Methods

=cut

.sub 'resume' :method
    .local pmc resume
    resume = self['resume']
    resume()
.end

.sub 'rethrow' :method
    rethrow self
.end


.sub 'perl' :method
    .return ('undef')
.end


.sub '' :vtable('get_string') :method
    .local pmc exception
    exception = getattribute self, '$!exception'
    $S0 = exception['message']
    .return ($S0)
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
