package Model::User;

use Dancer ':syntax';
use Carp;
use Util;

use Mouse;

extends 'Model';

has fio => (
    is          => 'rw',
    isa         => 'Str',
    required    => 1,
);
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
has sex => (
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
has x_real_ip   => (is => 'ro', isa => 'Any');
has last_visit  => (is => 'ro', isa => 'Any');

### Class methods

sub create {
    my ($class, %params) = @_;

    my $self = $class->new(%params);
    if ($self->validate) {
        return $self->insert;
        # w 'ok';
    }
    w 'nok';
}

sub login {
    my ($class, %params) = @_;
    return unless ($params{email} and $params{password});

    my ($self) = $class->list({ email => $params{email}, password => $params{password} });
    if ($self) {
        cookie code => $self->{regcode}, expires => '1 year';
        return $self;
    }

    return;
}

sub check_auth {
    my $class = shift;

    my $regcode = cookie 'code';
    my $self;
    if ($regcode) {
        ($self) = $class->list({ regcode => $regcode });
        unless ($self) {
            cookie code => '', expires => '0';
            return;
        }

        # my @roles = qw/admin manager content driver/;
        # if ($user->{role}) {
        #     if ($user->{role} eq 'admin') {
        #         map { $user->{acs}->{$_} = 1 } @roles;
        #     }
        #     else {
        #         for my $r (@roles) {
        #             if ($user->{role} eq $r) {
        #                 $user->{acs}->{$r} = 1;
        #                 $user->{acs}->{"$r\_only"} = 1;
        #             }
        #         }
        #     }
        # }

        $self->last_visit;
    }

    return $self;
}

### Object methods

sub validate {
    my $self = shift;

    my $error;
    if ($self->{email} !~ /@/) {
        $error->{email} = 1;
    }

    return $error ? $error : 1;
}

sub last_visit {
    my $self = shift;

    my $regcode = cookie 'code';
    if ($regcode) {
        # $self->{last_visit} = '2013-01-01';
        # $self->update;
        # database->quick_update('users', { regcode => $regcode }, { last_visit => func::now() });
    }

    return $self;
}


__PACKAGE__->meta->make_immutable();
