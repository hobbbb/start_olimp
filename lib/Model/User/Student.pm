package Model::User::Student;

use Dancer ':syntax';
use Carp;
use Util;

use Mouse;

extends 'Model::User';

has class => (
    is          => 'rw',
    isa         => 'Int',
    required    => 1,
);

__PACKAGE__->meta->make_immutable();
