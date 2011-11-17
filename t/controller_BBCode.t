use strict;
use warnings;
use Test::More;


use Catalyst::Test 'RNSP::CMS';
use RNSP::CMS::Controller::BBCode;

ok( request('/bbcode')->is_success, 'Request should succeed' );
done_testing();
