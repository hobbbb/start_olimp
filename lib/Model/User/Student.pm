package Model::User::Student;

use Dancer ':syntax';
use Carp;
use Util;

use Mouse;

extends 'Model::User';

has class_number => (
    is          => 'rw',
    isa         => 'Int',
    required    => 1,
);

### Object methods

sub validate {
    my $self = shift;

    my $fail = vars->{fail};
    for (qw/class_number/) {
        $fail->{$_} = 1 unless $self->{$_};
    }

    unless ($fail->{class_number}) {
        $fail->{class_number} = 1 if $self->{class_number} !~ /^\d+$/ or $self->{class_number} < 1 or $self->{class_number} > 11;
    }

    var fail => $fail;
}

__PACKAGE__->meta->make_immutable();
