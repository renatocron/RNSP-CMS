package RNSP::CMS::Controller::Proposta;
use Moose;
use namespace::autoclean;
 

BEGIN {extends 'Catalyst::Controller'; }


sub base : Chained('/base') PathPart('proposta') CaptureArgs(0) {
	my ($self, $c) = @_;
    $c->stash( admin => 1, title => 'Propostas' );

	if (!$c->user_exists) {
		$c->res->redirect('/admin/login'); return 0;
	}

}

sub lista: Chained('base') : PathPart('lista') Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Lista' );

	my $model = $c->model('Db');
	my @docs = $model->resultset('Proposta')->all;

	$c->stash( propostas => \@docs );

	my $msg = $c->flash->{message};
	$c->stash(message => $msg, error => $c->flash->{error}) if ($msg);
}

sub load : Chained('base') PathPart('') CaptureArgs(1){
	my ($self, $c, $id) = @_;

	my $model = $c->model('Db');

	my $proposta = $model->resultset('Proposta')->find($id);
	$c->stash( proposta => $proposta);

}

sub editar: Chained('load') :  Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Editar proposta', post => $c->req->params );

	if (%{$c->req->params} && $c->stash->{proposta}) {
		if (   $c->req->params->{diretriz}  =~ /^\d+$/
		    && $c->req->params->{documento_texto}
			&& $c->req->params->{documento_titulo}
			&& $c->req->params->{tema}      =~ /^\d+$/
			&& $c->req->params->{regiao}    =~ /^\d+$/ ){
			if (eval{$c->stash->{proposta}->id_documento->update({
				titulo => $c->req->params->{documento_titulo},
				texto  => $c->req->params->{documento_texto}
			})} && eval{$c->stash->{proposta}->update({
				id_diretriz  => $c->req->params->{diretriz},
				id_regiao    => $c->req->params->{regiao},
				id_tema      => $c->req->params->{tema},
			})}){
				$c->stash( message => 'Alteração feita com sucesso!!' );
				# segue sempre limpando o cache =/
				$c->cache->set("diretrizes-" . $_->id, undef, '0')
					for ($c->model('DB::Visao')->all);
			}else{
				$c->stash( message => 'Erro durante alteração', error => 1 );
			}
		}else{
			$c->stash( message => 'Erro no envio do formulário', error => 1 );
		}
	}

	my $model = $c->model('Db');
	my @docs = $model->resultset('Documento')->all;
	$c->stash( docs => \@docs );

	my @diretrizes = $model->resultset('Diretriz')->all;
	$c->stash( diretrizes => \@diretrizes);

	my @temas = $model->resultset('Tema')->all;
	$c->stash( temas => \@temas);

	my @regioes = $model->resultset('Regiao')->all;
	$c->stash( regioes => \@regioes);

	my @visoes = $model->resultset('Visao')->all;
	$c->stash( visoes => \@visoes);


	my $msg = $c->flash->{message};
	$c->stash(message => $msg) if ($msg);
}



sub boa_pratica_save: Chained('load'):  Args(0){
	my ($self, $c) = @_;

	if (   $c->req->params->{texto}
		&& $c->stash->{proposta}
		&& $c->req->params->{titulo}) {

		if ( $c->stash->{proposta}->boa_praticas->create({
				texto  => $c->req->params->{texto},
				titulo => $c->req->params->{titulo}
			}) ){
			$c->flash( message => 'Boa prática criado com sucesso!' );
			$c->cache->set("diretrizes-" . $_->id, undef, '0')
					for ($c->model('DB::Visao')->all);
		}else{
			$c->flash( message => 'Erro ao criar boa prática', error=>1 );
		}
	}else{
		$c->flash( message => 'Erro no POST', error=>1 );
	}
	$c->res->redirect($c->uri_for('/proposta', $c->stash->{proposta}->id, 'editar'));

}

sub boa_pratica_delete: Chained('load'): Args(1){
	my ($self, $c, $id) = @_;

	my $model = $c->model('Db');
	if(eval{$model->resultset('BoaPratica')->find($id)->delete}){
		$c->flash( message => 'Boa prática removida!' );
		$c->cache->set("diretrizes-" . $_->id, undef, '0')
					for ($c->model('DB::Visao')->all);
	}

	$c->res->redirect($c->uri_for('/proposta', $c->stash->{proposta}->id, 'editar'));
}

sub nova: Chained('base') :  Args(0){
	my ($self, $c) = @_;

	$c->stash( titlep => 'Nova' );

	my $model = $c->model('Db');

	my @temas = $model->resultset('Tema')->all;
	$c->stash( temas => \@temas);

	my @regioes = $model->resultset('Regiao')->all;
	$c->stash( regioes => \@regioes);

	my @visoes = $model->resultset('Visao')->all;
	$c->stash( visoes => \@visoes);

	my $msg = $c->flash->{message};
	$c->stash(message => $msg, error => $c->flash->{error}) if ($msg);
}


sub save: Chained('base') :  Args(0){
	my ($self, $c) = @_;

	if (   $c->req->params->{documento_texto}
		&& $c->req->params->{documento_titulo}
		&& $c->req->params->{diretriz}  =~ /^\d+$/
		&& $c->req->params->{tema}      =~ /^\d+$/
		&& $c->req->params->{regiao}    =~ /^\d+$/) {
		my $doc_rs = $c->model('Db::Documento');
		my ($doc, $di);
		if ( $doc = eval{$doc_rs->create({
				texto  => $c->req->params->{documento_texto},
				titulo => $c->req->params->{documento_titulo}
			})}
			and $di = eval{$doc->propostas->create({
				id_diretriz   => $c->req->params->{diretriz},
				id_tema       => $c->req->params->{tema},
				id_regiao     => $c->req->params->{regiao},
			})} ){
			$c->flash( message => 'Proposta adicionada com sucesso!' );
			$c->cache->set("diretrizes-" . $_->id, undef, '0')
					for ($c->model('DB::Visao')->all);

			$c->res->redirect($c->uri_for('/proposta', $di->id, 'editar'));
			return;
		}else{
			$c->flash( message => 'Erro ao atualizar proposta', error=>1 );
		}
	}else{
		$c->flash( message => 'Erro no POST', error=>1 );
	}

	$c->res->redirect($c->uri_for('/proposta', 'nova'));
}


=head1 AUTHOR

Renato santos,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
