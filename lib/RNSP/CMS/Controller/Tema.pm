package RNSP::CMS::Controller::Tema;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }


sub base : Chained('/base') PathPart('tema') CaptureArgs(0) {
	my ($self, $c) = @_;
    $c->stash( admin => 1, title => 'Temas' );


	if (!$c->user_exists) {
		$c->res->redirect($self->action_for('login'));
	}

}

sub novo: Chained('base') : PathPart('novo') Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Adicionar tema', post => $c->req->params );

	if (%{$c->req->params}) {
		if ( $c->req->params->{nome}  ){
			my $model = $c->model('DB::Tema');
			if (my $new = $model->create({
				nome => $c->req->params->{nome}
			})){
				$c->flash( message => 'Tema inserido com sucesso!!' );

				$c->res->redirect($c->uri_for( '/tema', $new->id, 'editar' ) );
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

	eval{$c->stash->{tema}->delete()};
	if ($@){
		my $fk = $@ =~ /foreign key constraint/i ? 'Tema ainda em uso!': '';
		$c->flash( error => 1, message => 'Erro ao apagar! ' . $fk );
	}

	$c->res->redirect($c->uri_for( '/tema/lista' ) );
}

sub lista: Chained('base') : PathPart('lista') Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Lista' );

	my $model = $c->model('Db');
	my @docs = $model->resultset('Tema')->all;

	$c->stash( temas => \@docs );

	my $msg = $c->flash->{message};
	$c->stash(message => $msg, error => $c->flash->{error}) if ($msg);
}

sub load : Chained('base') PathPart('') CaptureArgs(1){
	my ($self, $c, $id) = @_;

	my $model = $c->model('Db');

	my $tema = $model->resultset('Tema')->find($id);
	$c->stash( tema => $tema);

}

sub editar: Chained('load') :  Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Editar tema', post => $c->req->params );

	if (%{$c->req->params} && $c->stash->{tema}) {
		if ( $c->req->params->{nome} ){

			if ($c->stash->{tema}->update({
				nome => $c->req->params->{nome}
			})){
				$c->stash( message => 'Alteração feita com sucesso!!' );

				$c->cache->set("diretrizes-" . $_->id, undef, '0')
					for ($c->model('DB::Diretriz')->all);
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
