
use Test::More tests => 2;
use Test::Exception;
use strict;
use warnings;
use FindBin;
BEGIN { use_ok('Moose::Documenter') }

throws_ok {
  Moose::Documenter->new( "$FindBin::Bin/samplemoose/", 'badmodule' );
}
qr/This module is bad/, 'simple usage of example works.';

