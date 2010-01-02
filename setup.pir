#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.
# $Id$

=head1 NAME

setup.pir - Python distutils style

=head1 DESCRIPTION

No Configure step, no Makefile generated.

=head1 USAGE

    $ parrot setup.pir build
    $ parrot setup.pir test
    $ sudo parrot setup.pir install

=cut

.sub 'main' :main
    .param pmc args
    $S0 = shift args
    load_bytecode 'distutils.pbc'

    $P0 = new 'Hash'
    $P0['name'] = 'ChitChat'
    $P0['abstract'] = 'ChitChat'
    $P0['description'] = 'ChitChat'
    $P0['license_type'] = 'Artistic License 2.0'
    $P0['license_uri'] = 'http://www.perlfoundation.org/artistic_license_2_0'
    $P0['copyright_holder'] = 'Parrot Foundation'
    $P0['checkout_uri'] = 'https://svn.parrot.org/languages/chitchat/trunk'
    $P0['browser_uri'] = 'https://trac.parrot.org/languages/browser/chitchat'
    $P0['project_uri'] = 'https://trac.parrot.org/parrot/wiki/Languages'

    # build
    $P1 = new 'Hash'
    $P1['src/gen_grammar.pir'] = 'src/parser/grammar.pg'
    $P0['pir_pge'] = $P1

    $P2 = new 'Hash'
    $P2['src/gen_actions.pir'] = 'src/parser/actions.pm'
    $P0['pir_nqp'] = $P2

    $P3 = new 'Hash'
    $P4 = split "\n", <<'SOURCES'
src/chitchat.pir
src/gen_grammar.pir
src/gen_actions.pir
src/builtins.pir
src/builtins/say.pir
SOURCES
    $P3['chitchat/chitchat.pbc'] = $P4
    $P3['chitchat.pbc'] = 'chitchat.pir'
    $P0['pbc_pir'] = $P3

    $P5 = new 'Hash'
    $P5['parrot-chitchat'] = 'chitchat.pbc'
    $P0['installable_pbc'] = $P5

    # test
    $S0 = get_parrot()
    $S0 .= ' chitchat.pbc'
    $P0['prove_exec'] = $S0

    # install
    $P0['inst_lang'] = 'chitchat/chitchat.pbc'

    # dist
    $P0['doc_files'] = 'MAINTAINER'

    .tailcall setup(args :flat, $P0 :flat :named)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
