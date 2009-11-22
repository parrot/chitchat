# $Id$

=head1 TITLE

chitchat.pir - A ChitChat compiler.

=head2 Description

This is the base file for the ChitChat compiler.

This file includes the parsing and grammar rules from
the src/ directory, loads the relevant PGE libraries,
and registers the compiler under the name 'ChiChat'.

=head2 Functions

=over 4

=cut

.namespace [ 'Transcript' ]

.sub 'show:' :method
    .param pmc arg
    say arg
.end

.namespace []

.sub 'onload' :anon :load
    $P0 = newclass 'Transcript'
    $P0 = new 'Transcript'
    set_hll_global 'Transcript', $P0
.end

=item onload()

Creates the ChitChat compiler using a C<PCT::HLLCompiler>
object.

=cut

.namespace [ 'ChitChat::Compiler' ]

.loadlib 'chitchat_group'

.sub 'onload' :anon :load
    load_bytecode 'PCT.pbc'

    $P0 = get_hll_global ['PCT'], 'HLLCompiler'
    $P1 = $P0.'new'()
    $P1.'language'('ChitChat')
    $P1.'parsegrammar'('ChitChat::Grammar')
    $P1.'parseactions'('ChitChat::Grammar::Actions')
.end

=back

=cut

.include 'src/builtins.pir'
.include 'src/gen_grammar.pir'
.include 'src/gen_actions.pir'

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

