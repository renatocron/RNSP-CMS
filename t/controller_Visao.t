use strict;
use warnings;
use Test::More;


use Catalyst::Test 'RNSP::CMS';
use RNSP::CMS::Controller::Visao;

ok( request('/visao')->is_success, 'Request should succeed' );
done_testing();
