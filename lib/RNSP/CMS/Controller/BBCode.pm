package RNSP::CMS::Controller::BBCode;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

RNSP::CMS::Controller::BBCode - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


sub base : Chained('/base') PathPart('bbcode') CaptureArgs(0) {
	my ($self, $c) = @_;
    $c->stash( admin => 1, title => 'Dicas' );

}

sub root: Chained('base') : PathPart('') Args(0){
    my ( $self, $c ) = @_;

    
}


=head1 AUTHOR

Renato santos,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
