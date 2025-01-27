#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'RNSP-CMS';
all_from 'lib/RNSP/CMS.pm';

requires 'Catalyst::Runtime' => '5.90002';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
	
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
test_requires 'Test::More' => '0.88';

requires 'MooseX::NonMoose';
requires 'Catalyst::Plugin::Authorization';
requires 'CatalystX::Component::Traits' => 0.16;
requires 'Catalyst::Plugin::Cache';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::Store::Cache';
requires 'Catalyst::Plugin::Session::PerUser';
requires 'Catalyst::Plugin::Params::Nested';

requires 'Template::AutoFilter';
requires 'MooseX::MarkAsMethods';
requires 'DBIx::Class::TimeStamp';
requires 'HTML::BBCode';

requires 'Template::Plugin::HTML::BBCode';
requires 'Template::Plugin::Filter::HTMLScrubber';

requires 'Catalyst::Authentication::Credential::Password';
requires 'Catalyst::Restarter';
requires 'Cache::FileCache';
requires 'Catalyst::View::TT';
requires 'Catalyst::Model::DBIC::Schema';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
