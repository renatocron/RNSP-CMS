use strict;
use warnings;
use Test::More;


use Catalyst::Test 'RNSP::CMS';
use RNSP::CMS::Controller::Regiao;

ok( request('/regiao')->is_success, 'Request should succeed' );
done_testing();
