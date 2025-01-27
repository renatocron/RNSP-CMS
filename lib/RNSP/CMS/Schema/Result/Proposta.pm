use utf8;
package RNSP::CMS::Schema::Result::Proposta;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

RNSP::CMS::Schema::Result::Proposta

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

=head1 TABLE: C<proposta>

=cut

__PACKAGE__->table("proposta");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_tema

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_regiao

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_diretriz

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_documento

  data_type: 'int'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "id_tema",
  { data_type => "int", is_foreign_key => 1, is_nullable => 0 },
  "id_regiao",
  { data_type => "int", is_foreign_key => 1, is_nullable => 0 },
  "id_diretriz",
  { data_type => "int", is_foreign_key => 1, is_nullable => 0 },
  "id_documento",
  { data_type => "int", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 boa_praticas

Type: has_many

Related object: L<RNSP::CMS::Schema::Result::BoaPratica>

=cut

__PACKAGE__->has_many(
  "boa_praticas",
  "RNSP::CMS::Schema::Result::BoaPratica",
  { "foreign.id_proposta" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 id_diretriz

Type: belongs_to

Related object: L<RNSP::CMS::Schema::Result::Diretriz>

=cut

__PACKAGE__->belongs_to(
  "id_diretriz",
  "RNSP::CMS::Schema::Result::Diretriz",
  { id => "id_diretriz" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

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

=head2 id_regiao

Type: belongs_to

Related object: L<RNSP::CMS::Schema::Result::Regiao>

=cut

__PACKAGE__->belongs_to(
  "id_regiao",
  "RNSP::CMS::Schema::Result::Regiao",
  { id => "id_regiao" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_tema

Type: belongs_to

Related object: L<RNSP::CMS::Schema::Result::Tema>

=cut

__PACKAGE__->belongs_to(
  "id_tema",
  "RNSP::CMS::Schema::Result::Tema",
  { id => "id_tema" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07012 @ 2011-11-15 21:15:01
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vd7uEFew8HDryZdt7t8iSQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
