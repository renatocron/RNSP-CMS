use utf8;
package RNSP::CMS::Schema::Result::BoaPratica;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RNSP::CMS::Schema::Result::BoaPratica

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<boa_pratica>

=cut

__PACKAGE__->table("boa_pratica");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_proposta

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 0

=head2 texto

  data_type: 'varchar'
  is_nullable: 0

=head2 titulo

  data_type: 'varchar'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "id_proposta",
  { data_type => "int", is_foreign_key => 1, is_nullable => 0 },
  "texto",
  { data_type => "varchar", is_nullable => 0 },
  "titulo",
  { data_type => "varchar", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 id_proposta

Type: belongs_to

Related object: L<RNSP::CMS::Schema::Result::Proposta>

=cut

__PACKAGE__->belongs_to(
  "id_proposta",
  "RNSP::CMS::Schema::Result::Proposta",
  { id => "id_proposta" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07012 @ 2011-11-16 20:35:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KU5LWI5o5zkjy/GhNGvehg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
