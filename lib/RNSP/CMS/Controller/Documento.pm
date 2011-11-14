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

sub documento :Private {
    my ($self, $c, $id_documento) = @_;

	my $documento = $c->cache->get('documento-' . $id_documento);
	unless (defined $documento) {
		my $documento_rs = $c->model('DB')->resultset('Documento')->find($id_documento);

		$documento = {
			titulo => $documento_rs->titulo,
			texto  => $documento_rs->texto,
			created_at => $documento_rs->created_at
		};
		$c->cache->set("documento-$id_documento", $documento, '14 min');
	}

    $c->stash( documento => $documento );
}

sub base : Chained('/base') PathPart('documento') CaptureArgs(0) {
	my ($self, $c) = @_;
    $c->stash( admin => 1, title => 'Documentos' );

	
	if (!$c->user_exists) {
		$c->res->redirect($self->action_for('login'));
	}

}

sub novo: Chained('base') : PathPart('novo') Args(0){

}

sub lista: Chained('base') : PathPart('lista') Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Lista' );

	my $model = $c->model('Db');
	my @docs = $model->resultset('Documento')->all;

	$c->stash( docs => \@docs );
}

sub load : Chained('base') PathPart('') CaptureArgs(1){
	my ($self, $c, $id) = @_;

	my $model = $c->model('Db');

	my $doc = $model->resultset('Documento')->find($id);
	$c->stash( doc => $doc);

}
sub editar: Chained('load') :  Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Editar documento ' . $c->stash->{doc}->titulo );

}





=head1 AUTHOR

Renato santos,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
