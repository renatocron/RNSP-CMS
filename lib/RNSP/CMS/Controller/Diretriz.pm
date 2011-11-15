package RNSP::CMS::Controller::Diretriz;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

RNSP::CMS::Controller::Diretriz - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


sub base : Chained('/base') PathPart('diretriz') CaptureArgs(0) {
	my ($self, $c) = @_;
    $c->stash( admin => 1, title => 'Diretrizes' );

	if (!$c->user_exists) {
		$c->res->redirect($self->action_for('login'));
	}

}

sub lista: Chained('base') : PathPart('lista') Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Lista' );

	my $model = $c->model('Db');
	my @visoes = $model->resultset('Visao')->search(undef, {
			prefetch => ['diretrizzes'], order_by => 'me.id'
	})->all;
	$c->stash( visoes => \@visoes );

}

sub por_visao: Chained('base') : PathPart('por_visao') Args(0){
	my ($self, $c) = @_;
    $c->stash( titlep => 'Por visão' );

	$self->por_visao_save($c) if (%{$c->req->params});

	my $model = $c->model('Db');

	my @visoes = $model->resultset('Visao')->search(undef, {prefetch => ['diretrizzes'], order_by => 'me.id'})->all;
	$c->stash( visoes => \@visoes );

	my @docs = $model->resultset('Documento')->search(undef, {prefetch => ['diretrizzes'], order_by => 'me.id'})->all;
	$c->stash( docs => \@docs );

}

sub por_visao_save: Private {
	my ($self, $c) = @_;
    
	my $model = $c->model('Db');

	if (%{$c->req->params}) {

		my $check = $c->req->params->{diretriz};
		$model->txn_do(sub {
			my @visoes = $model->resultset('Visao')->search(undef, {prefetch => ['diretrizzes'], order_by => 'me.id'})->all;
			my @docs = $model->resultset('Documento')->search(undef, {prefetch => ['diretrizzes']})->all;

			my $diretrizes = $model->resultset('Diretriz');

			foreach my $d (@docs){
				foreach my $v (@visoes){
					my $found = undef;
					foreach my $di ( $v->diretrizzes ){
						$found = $di if $di->id_documento->id == $d->id;
					}

					if (defined $found){
						# alguem foi desmarcado, precisa apagar todos os filhos
						if ( !$check->[$d->id][$v->id] ){
							$found->indicadors->delete();
							$found->propostas->delete();
							$found->delete();
						}
					}elsif($check->[$d->id][$v->id] && $check->[$d->id][$v->id] == -1 ){

						$v->diretrizzes->create({
							id_documento => $d->id
						});
					}

					$c->cache->set('diretrizes-'.$v->id, undef, '0min');

				}

			}
		});
	}

}

sub load : Chained('base') PathPart('') CaptureArgs(1){
	my ($self, $c, $id) = @_;

	my $model = $c->model('Db');

	my $di = $model->resultset('Diretriz')->find($id);
	$c->stash( di => $di);

}

sub editar: Chained('load') :  Args(0){
	my ($self, $c) = @_;

	$c->stash( titlep => 'Editar' );

	my $model = $c->model('Db');

	my @docs = $model->resultset('Documento')->all;
	$c->stash( docs => \@docs );

	my @visoes = $model->resultset('Visao')->all;
	$c->stash( visoes => \@visoes);

	my $msg = $c->flash->{message};
	$c->stash(message => $msg) if ($msg);
}

sub editar_save: Chained('load') :  Args(0){
	my ($self, $c) = @_;

	if (   $c->req->params->{documento} =~ /^\d+$/
		&& $c->req->params->{visao}     =~ /^\d+$/) {

		my $id_visao_old = $c->stash->{di}->id_visao->id;
		$c->cache->set('diretrizes-'.$id_visao_old, undef, '0min');

		if ( $c->stash->{di}->update({
				id_documento => $c->req->params->{documento},
				id_visao     => $c->req->params->{visao}
			}) ){
			$c->flash( message => 'Diretriz alterada com sucesso!' );
			$c->cache->set('diretrizes-'.$c->req->params->{visao}, undef, '0min');
			
		}else{
			$c->flash( message => 'Erro ao atualizar diretriz', error=>1 );
		}
	}else{
		$c->flash( message => 'Erro no POST', error=>1 );
	}
	$c->res->redirect($c->uri_for('/diretriz', $c->stash->{di}->id, 'editar'));
}

=head1 AUTHOR

Renato santos,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
