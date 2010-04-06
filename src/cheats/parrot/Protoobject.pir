## $Id$

=head1 TITLE

Protoobject - methods on Protoobjects

=head1 DESCRIPTION

=head2 Methods on P6protoobject

=over

=item defined()

=cut

.namespace ['P6protoobject']
.sub 'defined' :method
    $P0 = get_root_global [.RAKUDO_HLL ; 'Bool'], 'False'
    .return ($P0)
.end


=item perl()

Returns a Perl representation of itself.

=cut

.sub 'perl' :method
    $S0 = self
    $I0 = length $S0
    if $I0 < 2 goto done
    $I0 -= 2
    $S0 = substr $S0, 0, $I0
  done:
    .return ($S0)
.end

=item WHENCE()

Returns the protoobject's autovivification closure.

=cut

.namespace ['P6protoobject']
.sub 'WHENCE' :method
    .local pmc whence
    whence = getprop '%!WHENCE', self
    unless null whence goto done
    whence = new 'Undef'
  done:
    .return (whence)
.end


=item WHICH()

Returns a comparable identifier for the proto-object.

=cut

.sub 'WHICH' :method
    $P0 = self.'HOW'()
    $I0 = get_addr $P0
    .return ($I0)
.end


=back

=head2 Functions

=over

=item postcircumfix:<{ }>

Return a clone of the protoobject with a new WHENCE property set.

=cut

.namespace ['P6protoobject']
.sub 'postcircumfix:{ }' :method
    .param pmc WHENCE :slurpy :named
    .local pmc protoclass, proto
    protoclass = typeof self
    proto = new protoclass
    setprop proto, '%!WHENCE', WHENCE
    .return (proto)
.end


=back

=head2 Vtable functions

=cut

.namespace ['P6protoobject']
.sub '' :vtable('get_bool') :method
#    .const 'Sub' $P1 = '!FAIL'
    # I don't think boolean context should warn, no? --moritz
#    $P0 = $P1('Use of type object as value in boolean context')
##    $I0 = istrue $P0
#    .return ($I0)
    .return (0)
.end

.namespace ['P6protoobject']
.sub '' :vtable('get_integer') :method
    .return (0)
.end

.namespace ['P6protoobject']
.sub '' :vtable('get_number') :method
    .return (0.0)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
