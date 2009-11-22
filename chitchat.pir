# $Id$

=head1 TITLE

chitchat.pir - A ChitChat compiler.

=head2 Description

This is the entry point for the ChitChat compiler.

=head2 Functions

=over 4

=item main(args :slurpy)  :main

Start compilation by passing any command line C<args>
to the ChitChat compiler.

=cut

.sub 'main' :main
    .param pmc args

    load_language 'chitchat'

    $P0 = compreg 'ChitChat'
    $P1 = $P0.'command_line'(args)
.end

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

