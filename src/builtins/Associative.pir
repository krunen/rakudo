## $Id$

=head1 NAME

src/classes/Associative.pir - Associative Role

=head1 DESCRIPTION

=cut

.namespace ['Associative[::T]']

.sub '' :load :init
    # Create a parametric role with 1 possible candidate.
    .local pmc role
    .const 'Sub' $P0 = '_Associative_role_body'
    role = new ['Perl6Role']
    $P1 = box 'Associative'
    setattribute role, '$!shortname', $P1
    role.'!add_variant'($P0)
    set_hll_global 'Associative', role
.end


# This defines the body of the role, which is run per type the role is
# parameterized with.
.sub '' :anon :subid('_Associative_role_body')
    .param pmc type :optional

    # Need to capture the methods that belong in this role.
    .const 'Sub' $P1 = 'Associative::of'
    capture_lex $P1

    # Capture type.
    if null type goto no_type
    type = type.'WHAT'()
    goto type_done
  no_type:
    type = get_hll_global 'Mu'
  type_done:
    .lex 'T', type

    # Create role.
    .tailcall '!create_parametric_role'("Associative[::T]")
.end
.sub '' :load :init
    .local pmc block, signature
    .const 'Sub' $P0 = '_Associative_role_body'
    block = $P0
    signature = allocate_signature 1
    setprop block, "$!signature", signature
    null $P1
    set_signature_elem signature, 0, "T", SIG_ELEM_IS_OPTIONAL, $P1, $P1, $P1, $P1, $P1, $P1, ""
.end


=head2 Methods

=over

=item postcircumfix:<{ }>

=cut

.namespace ['Associative[::T]']
.sub 'postcircumfix:<{ }>' :method :multi(_, _)
    .param pmc key
    .local pmc result
    result = self[key]
    unless null result goto have_result
    result = new ['Perl6Scalar']
  have_result:
    .return (result)
.end

=item of

Returns the type constraining what may be stored.

=cut

.sub 'of' :method :outer('_Associative_role_body') :subid('Associative::of')
    $P0 = find_lex 'T'
    .return ($P0)
.end
.sub '' :load :init
    .local pmc block, signature
    .const 'Sub' block = 'Associative::of'
    signature = allocate_signature 0
    setprop block, "$!signature", signature
.end

=item !postcircumfix:<{ }>

Because foreign (non-Rakudo) Parrot objects generally won't
understand the "postcircumfix:<{ }>" method, we generate
postcircumfix as a private call to this function, and this
function then delegates to the appropriate method.  For PMCs
that don't have a postcircumfix:<{ }> method, we'll have to
fake it later.

=cut

.namespace []
.sub '!postcircumfix:<{ }>'
    .param pmc invocant
    .param pmc args            :slurpy
    $I0 = can invocant, 'postcircumfix:<{ }>'
    if $I0 goto object_method
    $I0 = isa invocant, 'Mu'
    if $I0 goto object_method
  foreign:
    # XXX relies on the method being in the namespace -- perhaps
    # should use method lookup instead
    $P0 = get_hll_global ['Associative[::T]'], 'postcircumfix:<{ }>'
    .tailcall invocant.$P0(args :flat)
  object_method:
    .tailcall invocant.'postcircumfix:<{ }>'(args :flat)
.end

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

