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
	my ($self, $c) = @_;
    $c->stash( titlep => 'Adicionar documento', post => $c->req->params );

	if (%{$c->req->params}) {
		if ( $c->req->params->{titulo} && $c->req->params->{texto} ){
			my $model = $c->model('DB::Documento');
			if (my $new = $model->create({
				titulo => $c->req->params->{titulo},
				texto  => $c->req->params->{texto} 
			})){
				$c->flash( message => 'Documento inserido com sucesso!!' );

				$c->res->redirect($c->uri_for( '/documento', $new->id, 'editar' ) );
				return 0;
			}else{
				$c->stash( message => 'Erro durante insersão', error => 1 );
			}
		}else{
			$c->stash( message => 'Erro no envio do formulário', error => 1 );
		}
	}
}

sub apagar: Chained('load') :  Args(0){
	my ($self, $c) = @_;
	
	eval{$c->stash->{doc}->delete()};
	if ($@){
		my $fk = $@ =~ /foreign key constraint/i ? 'Documento ainda em uso!': '';
		$c->flash( error => 1, message => 'Erro ao apagar! ' . $fk );
	}

	$c->res->redirect($c->uri_for( '/documento/lista' ) );
}

sub lista: Chained('base') : PathPart('lista') Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Lista' );

	my $model = $c->model('Db');
	my @docs = $model->resultset('Documento')->all;

	$c->stash( docs => \@docs );

	my $msg = $c->flash->{message};
	$c->stash(message => $msg, error => $c->flash->{error}) if ($msg);
}

sub load : Chained('base') PathPart('') CaptureArgs(1){
	my ($self, $c, $id) = @_;

	my $model = $c->model('Db');

	my $doc = $model->resultset('Documento')->find($id);
	$c->stash( doc => $doc);

}

sub editar: Chained('load') :  Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Editar documento', post => $c->req->params );

	# nao pode ter uma visao (pra nao sair o site do nada)
	unless( $c->model('DB::Visao')->search({ id_documento => $c->stash->{doc}->id })->count ){
		$c->stash( remover => 1 ) if ($c->stash->{doc}->id != 1); # nem ser a home-page
	}

	if (%{$c->req->params} && $c->stash->{doc}) {
		if ( $c->req->params->{titulo} && $c->req->params->{texto} ){
			
			if ($c->stash->{doc}->update({
				titulo => $c->req->params->{titulo},
				texto  => $c->req->params->{texto} 
			})){
				$c->stash( message => 'Alteração feita com sucesso!!' );
				$c->cache->set("documento-" . $c->stash->{doc}->id, undef, '0');
			}else{
				$c->stash( message => 'Erro durante alteração', error => 1 );
			}
		}else{
			$c->stash( message => 'Erro no envio do formulário', error => 1 );
		}
	}

	my $msg = $c->flash->{message};
	$c->stash(message => $msg) if ($msg);
}





=head1 AUTHOR

Renato santos,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
