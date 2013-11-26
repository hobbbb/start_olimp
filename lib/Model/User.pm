package Model::User;

use Carp;
use Util;

use Mouse;

extends 'Model';

has email => (
    is          => 'rw',
    isa         => 'Str',
    required    => 1,
);
has password => (
    is          => 'rw',
    isa         => 'Str',
    required    => 1,
);
has regcode => (
    is          => 'ro',
    isa         => 'Str',
    default     => Util::generate,
    required    => 1,
);
has registered  => (is => 'ro', isa => 'Str');
has x_real_ip   => (is => 'ro', isa => 'Str');
has last_visit  => (is => 'ro', isa => 'Str');

### Class methods

sub create {
    my ($class, %params) = @_;

    my $self = $class->new(%params);
    if ($self->validate) {
        # return $self->insert;
        w 'ok';
    }
    w 'nok';
}

### Object methods

sub validate {
    my $self = shift;
    croak 'No object' unless $self;

    if ($self->{email} !~ /@/) {
        return;
    }

    return 1;
}

__PACKAGE__->meta->make_immutable();
