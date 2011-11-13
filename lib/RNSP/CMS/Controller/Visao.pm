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

sub visao :Path :Args(1) :Private {
    my ( $self, $c, $texto_uri ) = @_;

	$self->stash_visao($c, $texto_uri);

	unless (defined $c->stash->{visao}){
		$c->detach('RNSP::CMS::Controller::Root', 'error_404');
	}

    $c->response->body("$texto_uri");
		
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

=head1 AUTHOR

Renato santos,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
