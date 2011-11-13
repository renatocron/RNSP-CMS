use utf8;
package RNSP::CMS::Schema::Result::Diretriz;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RNSP::CMS::Schema::Result::Diretriz

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

=head1 TABLE: C<diretriz>

=cut

__PACKAGE__->table("diretriz");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_visao

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_documento

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "id_visao",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_documento",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
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

=head2 id_visao

Type: belongs_to

Related object: L<RNSP::CMS::Schema::Result::Visao>

=cut

__PACKAGE__->belongs_to(
  "id_visao",
  "RNSP::CMS::Schema::Result::Visao",
  { id => "id_visao" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 indicadors

Type: has_many

Related object: L<RNSP::CMS::Schema::Result::Indicador>

=cut

__PACKAGE__->has_many(
  "indicadors",
  "RNSP::CMS::Schema::Result::Indicador",
  { "foreign.id_diretriz" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 propostas

Type: has_many

Related object: L<RNSP::CMS::Schema::Result::Proposta>

=cut

__PACKAGE__->has_many(
  "propostas",
  "RNSP::CMS::Schema::Result::Proposta",
  { "foreign.id_diretriz" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07012 @ 2011-11-13 14:23:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:x8uFMw5fS9I72w6LP8vsRw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
