package RNSP::CMS::Controller::Visao;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

RNSP::CMS::Controller::Visao - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub sp2022 :Path('/sp2022') :Args(1) {
    my ( $self, $c, $texto_uri ) = @_;

	$self->stash_visao($c, $texto_uri);

	$c->detach('RNSP::CMS::Controller::Root', 'error_404') unless (defined $c->stash->{visao});

	# se existe visao, coloca as diretrizes tambem
	$self->stash_diretrizes($c, $c->stash->{visao}->{id});

	# se tem a visao, carregue o documento!
	$c->forward('RNSP::CMS::Controller::Documento', 'documento', [ $c->stash->{visao}{id_documento} ]);

}

sub sp2022_diretriz :Path('/sp2022') :Args(2) {
    my ( $self, $c, $texto_uri, $id_diretriz ) = @_;

	$self->stash_visao($c, $texto_uri);

	$c->detach('RNSP::CMS::Controller::Root', 'error_404') unless (defined $c->stash->{visao});

	$c->detach('RNSP::CMS::Controller::Root', 'error_404') unless
		$self->stash_diretrizes($c, $c->stash->{visao}->{id}, $id_diretriz);

	$c->forward('RNSP::CMS::Controller::Documento', 'documento', [ $c->stash->{diretriz}{id_documento} ]);

}


sub stash_visao : Private {
    my ( $self, $c, $texto_uri ) = @_;

	my $visao = $c->cache->get('visao-'.$texto_uri);
	unless ($visao){
		$visao = $c->model('DB')->resultset('Visao')->search({
			texto_uri => $texto_uri
		}, {
			result_class => 'DBIx::Class::ResultClass::HashRefInflator'
		})->first;
		
		$c->cache->set('visao-'.$texto_uri, $visao);
	}
	$c->stash( visao => $visao );
}

sub stash_diretrizes : Private {
    my ( $self, $c, $id_visao, $id_diretriz ) = @_;

	my $diretrizes = $c->cache->get('diretrizes-'.$id_visao);
	unless ($diretrizes){
		my @diretrizes_rows = $c->model('DB')->resultset('Diretriz')->search({
			id_visao => $id_visao
		})->all;
		$diretrizes = [];
		foreach my $d (@diretrizes_rows){
			push @$diretrizes, {
				id_documento => $d->id_documento->id,
				id => $d->id,
				titulo => $d->id_documento->titulo,
				texto => $d->id_documento->texto
			}
		}
		$c->cache->set('diretrizes-'.$id_visao, $diretrizes);
	}

	$c->stash( diretrizes => $diretrizes );

	if (defined $id_diretriz) {
		foreach (@$diretrizes){
			if ($_->{id} == $id_diretriz){
				$c->stash( diretriz => $_ );
				return 1;
			}
		}
		return 0;
	}	

}



=head1 AUTHOR

Renato santos,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;