package RNSP::CMS::Controller::Documento;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

RNSP::CMS::Controller::Documento - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub documento: Args(1) :Private {
    my ($self, $c, $id_documento) = @_;

	my $documento = $c->cache->get('documento-' . $id_documento);
	unless (defined $id_documento) {
		my $documento_rs = $c->model('DB')->resultset('Documento')->find($id_documento);

		$documento = {
			titulo => $documento_rs->titulo,
			texto  => $documento_rs->texto,
			created_at => $documento_rs->created_at
		};
		$c->cache->set("documento-$id_documento", $documento);
	}

    $c->stash( documento => $documento );
}


=head1 AUTHOR

Renato santos,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
