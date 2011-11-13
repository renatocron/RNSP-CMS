use utf8;
package RNSP::CMS::Schema::Result::Indicador;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RNSP::CMS::Schema::Result::Indicador

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

=head1 TABLE: C<indicador>

=cut

__PACKAGE__->table("indicador");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_diretriz

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 1

=head2 descricao

  data_type: 'varchar'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "id_diretriz",
  { data_type => "int", is_foreign_key => 1, is_nullable => 1 },
  "descricao",
  { data_type => "varchar", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 id_diretriz

Type: belongs_to

Related object: L<RNSP::CMS::Schema::Result::Diretriz>

=cut

__PACKAGE__->belongs_to(
  "id_diretriz",
  "RNSP::CMS::Schema::Result::Diretriz",
  { id => "id_diretriz" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07012 @ 2011-11-13 13:24:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Jpebkup21SEhJ4358+YIJw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
