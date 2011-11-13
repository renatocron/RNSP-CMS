#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use lib qw (../lib/ lib);


use RNSP::CMS::Schema;
use Template;

my $schema = RNSP::CMS::Schema->connect('dbi:SQLite:rnsp.db', '', '');

my @visoes = $schema->resultset('Visao')->all;

my $template = Template->new({});
my $vars = {
	visoes => []
};
foreach my $row (@visoes) {
	my @itens = split /\s/, $row->texto_menu;
	
	push @{$vars->{visoes}}, {
		id => $row->id,
		texto_uri => $row->texto_uri,
		itens => \@itens
	};
}
die 'root/src/visoes.base.tt nao encontrado' unless -e 'root/src/visoes.base.tt';

$template->process('root/src/visoes.base.tt', $vars, 'root/src/visoes.tt.new') || die $template->error();
use File::Copy;
move('root/src/visoes.tt.new', 'root/src/visoes.tt') || die("Erro ao mover root/src/visoes.tt.new");






