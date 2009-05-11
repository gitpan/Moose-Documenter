
use Test::More tests => 2;
use Test::Exception;
use strict;
use warnings;
BEGIN { use_ok('Moose::Documenter') }

throws_ok {
  Moose::Documenter->new( "randomstringthatshouldnotexist/", 'basicsimple' );
}
qr/Directory can not/, 'Correctly threw error with bad directory';
