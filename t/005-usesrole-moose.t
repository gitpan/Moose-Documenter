
use Test::More tests => 10;
use strict;
use warnings;
use FindBin;
BEGIN { use_ok('Moose::Documenter') }

ok( Moose::Documenter->new( "$FindBin::Bin/samplemoose/", 'usesrole' ),
  'simple usage of example works.' );

my $doc = Moose::Documenter->new( "$FindBin::Bin/samplemoose/", 'usesrole' );
$doc->setmooselib("$FindBin::Bin/samplemoose");

is_deeply(
  $doc->local_attributes,
  {
    'x' => { isa => 'Int', is => 'rw', modifiers => 'required' },
    'y' => { isa => 'Int', is => 'rw', modifiers => 'required' }
  },
  'got expected return from local_attributes'
);

is_deeply( $doc->inherited_attributes, undef,
  'got expected return from inherited_attributes' );

is_deeply(
  $doc->local_methods,
  {
    meta    => undef,
    'clear' => 'sub clear {
  my $self = shift;
  $self->x(0);
  $self->y(0);
}'
  },
  'got expected return from local_methods'
);

my $inherited_methods = $doc->inherited_methods;
isa_ok( $inherited_methods, 'HASH', 'inherited_methods return is hash' );
isa_ok( $inherited_methods->{'Moose::Object'},
  'HASH', 'Key, Moose::Object in hash' );
delete( $inherited_methods->{'Moose::Object'} );
is_deeply(
  $inherited_methods,
  {
    'basicrole' => {
      'not_equal_to' => 'sub not_equal_to {
  my( $self, $other ) = @_;
  not $self->equal_to($other);
}'
    }
  },
  'got expected return from inherited_methods'
);

is_deeply( $doc->class_parents, ['Moose::Object'],
  'got expected return from class_parents' );

is_deeply( $doc->roles, ['basicrole'], 'got expected return from roles' );

