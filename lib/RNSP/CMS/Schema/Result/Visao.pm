use utf8;
package RNSP::CMS::Schema::Result::Visao;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RNSP::CMS::Schema::Result::Visao

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

=head1 TABLE: C<visao>

=cut

__PACKAGE__->table("visao");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_documento

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 0

=head2 texto_menu

  data_type: 'varchar'
  is_nullable: 0
  size: 120

=head2 texto_uri

  data_type: 'varchar'
  is_nullable: 0
  size: 120

=head2 created_at

  data_type: 'timestamp date'
  default_value: datetime('now','localtime')
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "id_documento",
  { data_type => "int", is_foreign_key => 1, is_nullable => 0 },
  "texto_menu",
  { data_type => "varchar", is_nullable => 0, size => 120 },
  "texto_uri",
  { data_type => "varchar", is_nullable => 0, size => 120 },
  "created_at",
  {
    data_type     => "timestamp date",
    default_value => \"datetime('now','localtime')",
    is_nullable   => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 id_documento

Type: belongs_to

Related object: L<RNSP::CMS::Schema::Result::Documento>

=cut

__PACKAGE__->belongs_to(
  "id_documento",
  "RNSP::CMS::Schema::Result::Documento",
  { id => "id_documento" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07012 @ 2011-11-12 22:53:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8ZfzUFYZQeNoZtefOoAQeA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
