package RNSP::CMS::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config( namespace => '' );

=head1 NAME

RNSP::CMS::Controller::Root - Root Controller for RNSP::CMS

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub base : Chained('/') PathPart('') CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub root : Chained('base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;

	$c->forward('RNSP::CMS::Controller::Documento', 'documento', [1]); # carregando o documento 1 no stash // doc 1 = home

}

=head2 default

Standard 404 error page

=cut

sub error_404 : Chained('base') PathPart('') Args {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'error_404.tt';
    $c->response->status(404);
}


sub error_500 : Private {
    my ( $self, $c ) = @_;
    $c->response->status(500);
    $c->stash->{template} = 'error_500.tt';
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
}

=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
