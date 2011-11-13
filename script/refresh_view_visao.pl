#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use lib qw (../lib/ ..);


use RNSP::CMS::Schema;
use JSON;

my $schema = RNSP::CMS::Schema->connect('dbi:Pg:host=localhost;dbname=rnsp.db', '', '');

my @visoes = $schema->resultset('Visao')->all;

foreach $v (@visoes) {

}






