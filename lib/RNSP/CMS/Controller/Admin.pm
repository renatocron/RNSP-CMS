package RNSP::CMS::Controller::Admin;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

RNSP::CMS::Controller::Admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base : Chained('/base') PathPart('admin') CaptureArgs(0) {
	my ($self, $c) = @_;
    $c->stash( admin => 1, titlep => 'Administração' );

	unless ( $c->action eq $self->action_for('logout') || $c->action eq $self->action_for('login') ){
		if (!$c->user_exists) {
			$c->res->redirect($self->action_for('login'));
		}
	}
}

sub logout : Chained('base') Args(0) {
	my ($self, $c) = @_;
	$c->logout();
	$c->res->redirect('/');
}

sub login : Chained('base') Args(0) {
	my ($self, $c) = @_;

	 if (my $user     = $c->req->params->{user}
	 and my $password = $c->req->params->{pass} ) {
		if ( $c->authenticate( { username => $user,
								 password => $password } ) ) {
			$c->res->redirect('/admin');
		} else {
			$c->stash( titlep => 'Usuário ou senha inválidos' );
		}
	}
	
	$c->stash( title => 'autenticação' );

 
}

sub root : Chained('base'): PathPart('') Args(0) {
    my ($self, $c) = @_;
    $c->stash( title => 'Menu' );
}


=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
 