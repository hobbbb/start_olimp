package Model::User::Admin;

use Dancer ':syntax';
use Carp;
use Util;

use Mouse;

extends 'Model::User';

__PACKAGE__->meta->make_immutable();
