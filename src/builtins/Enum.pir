## $Id$

=head1 NAME

src/classes/Enum.pir - methods for the Enum class

=head1 Methods

=over 4

=cut

.namespace ['Enum']

.sub 'onload' :anon :load :init
    .local pmc p6meta, pairproto
    p6meta = get_hll_global ['Mu'], '$!P6META'
    pairproto = p6meta.'new_class'('Enum', 'parent'=>'Cool', 'attr'=>'$!key $!value')
.end


=item key

Gets the key of the pair.

=cut

.sub 'key' :method
    $P0 = getattribute self, '$!key'
    .return ($P0)
.end

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
