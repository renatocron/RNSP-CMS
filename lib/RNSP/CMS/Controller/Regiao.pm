package RNSP::CMS::Controller::Regiao;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }


sub base : Chained('/base') PathPart('regiao') CaptureArgs(0) {
	my ($self, $c) = @_;
    $c->stash( admin => 1, title => 'Regiões' );

	if (!$c->user_exists) {
		$c->res->redirect('/admin/login'); return 0;
	}

}

sub nova: Chained('base') : PathPart('nova') Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Adicionar regiao', post => $c->req->params );

	if (%{$c->req->params}) {
		if ( $c->req->params->{nome}  ){
			my $model = $c->model('DB::Regiao');
			if (my $new = $model->create({
				nome => $c->req->params->{nome}
			})){
				$c->flash( message => 'Regiao inserido com sucesso!!' );

				$c->res->redirect($c->uri_for( '/regiao', $new->id, 'editar' ) );
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

	eval{$c->stash->{regiao}->delete()};
	if ($@){
		my $fk = $@ =~ /foreign key constraint/i ? 'Regiao ainda em uso!': '';
		$c->flash( error => 1, message => 'Erro ao apagar! ' . $fk );
	}

	$c->res->redirect($c->uri_for( '/regiao/lista' ) );
}

sub lista: Chained('base') : PathPart('lista') Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Lista' );

	my $model = $c->model('Db');
	my @docs = $model->resultset('Regiao')->all;

	$c->stash( regioes => \@docs );

	my $msg = $c->flash->{message};
	$c->stash(message => $msg, error => $c->flash->{error}) if ($msg);
}

sub load : Chained('base') PathPart('') CaptureArgs(1){
	my ($self, $c, $id) = @_;

	my $model = $c->model('Db');

	my $regiao = $model->resultset('Regiao')->find($id);
	$c->stash( regiao => $regiao);

}

sub editar: Chained('load') :  Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Editar regiao', post => $c->req->params );

	if (%{$c->req->params} && $c->stash->{regiao}) {
		if ( $c->req->params->{nome} ){

			if ($c->stash->{regiao}->update({
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
