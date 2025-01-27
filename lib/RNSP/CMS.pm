package RNSP::CMS;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
  -Debug
  ConfigLoader
  Static::Simple

	Authentication
	
	Session
	Session::Store::Cache
	Session::State::Cookie
	Session::PerUser

	Cache

	Params::Nested

  /;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in rnsp_cms.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'RNSP::CMS',

    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
);

__PACKAGE__->config(
    'View::TT' => {
        INCLUDE_PATH => [
            map { __PACKAGE__->path_to(@$_) }[qw(root src)], [qw(root lib)],
            [qw(root wrapper)]
        ]
    }
);


__PACKAGE__->config->{'Plugin::Cache'}{backend} = {
 	class => 'Cache::FileCache',
	default_expires_in => 60 * 60 * 12,
	cache_root => 'cache/filecache'
};

__PACKAGE__->config(
	"Plugin::Session" => {
		expires => 60 * 60,
	},
);

# Configure SimpleDB Authentication
__PACKAGE__->config(
	'Plugin::Authentication' => {
		default => {
			credential => {
				class           => 'Password',
				password_field => 'password',
				password_type => 'clear'
			}
		},
	},
);
__PACKAGE__->config( 'Plugin::ConfigLoader' => { file => 'user.json' } );


# Start the application
__PACKAGE__->setup();

=head1 NAME

RNSP::CMS - Catalyst based application

=head1 SYNOPSIS

    script/rnsp_cms_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<RNSP::CMS::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
