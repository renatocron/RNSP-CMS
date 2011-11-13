use strict;
use warnings;
use Test::More;


use Catalyst::Test 'RNSP::CMS';
use RNSP::CMS::Controller::Documento;

ok( request('/documento')->is_success, 'Request should succeed' );
done_testing();
