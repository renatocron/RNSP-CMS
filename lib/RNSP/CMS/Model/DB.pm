package RNSP::CMS::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'RNSP::CMS::Schema',
    
    connect_info => {
<<<<<<< HEAD
        dsn => 'dbi:SQLite:rnsp.db',
        user => '',
        password => '',
        on_connect_do => q{PRAGMA foreign_keys = ON},
=======
        dsn => 'dbi:SQLite:test.db',
        user => '',
        password => '',
>>>>>>> 53fc42ddb84b7a70240f6ee5acc1d63de1e200db
    }
);

=head1 NAME

RNSP::CMS::Model::DB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<RNSP::CMS>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<RNSP::CMS::Schema>

=head1 GENERATED BY

<<<<<<< HEAD
Catalyst::Helper::Model::DBIC::Schema - 0.59

=head1 AUTHOR

Renato santos
=======
Catalyst::Helper::Model::DBIC::Schema - 0.5

=head1 AUTHOR

Thiago Rondon
>>>>>>> 53fc42ddb84b7a70240f6ee5acc1d63de1e200db

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
