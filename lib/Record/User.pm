package Record::User;

use Dancer ':syntax';
use Carp;
use Util;

use Mouse;

extends 'Record';

has fio => (
    is          => 'rw',
    isa         => 'Str',
    # required    => 1,
);
has email => (
    is          => 'rw',
    isa         => 'Str',
    # required    => 1,
);
has password => (
    is          => 'rw',
    isa         => 'Str',
    # required    => 1,
);
has sex => (
    is          => 'rw',
    isa         => 'Str',
    # required    => 1,
);
has regcode => (
    is          => 'ro',
    isa         => 'Str',
    default     => Util::generate,
    required    => 1,
);
has registered => (
    is          => 'ro',
    isa         => 'Str',
    default     => Util::now,
);
has class_number => (
    is          => 'rw',
    isa         => 'Str',
    # required    => 1,
);
has x_real_ip   => (is => 'ro', isa => 'Any');
has last_visit  => (is => 'rw', isa => 'Any');

### Class methods
sub create {
    my ($class, %params) = @_;

    my $self = $class->new(%params);
    return $self->insert;
}

sub login {
    my ($class, %params) = @_;
    return unless ($params{email} and $params{password});

    my $self = $class->list({ email => $params{email}, password => $params{password} });
    if ($self) {
        cookie code => $self->regcode, expires => '1 year';
        return $self;
    }

    return;
}

sub check_auth {
    my $class = shift;

    my $regcode = cookie 'code';
    my $self;
    if ($regcode) {
        $self = $class->list({ regcode => $regcode });
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

sub last_visit {
    my $self = shift;

    my $regcode = cookie 'code';
    if ($regcode) {
        # $self->last_visit('2013-01-01');
        # $self->update;
        # database->quick_update('users', { regcode => $regcode }, { last_visit => func::now() });
    }

    return $self;
}

### Modificators

before 'insert' => sub {
    my $self = shift;

    # $self->validate;

    my $fail = vars->{fail};
    for (qw/fio email password sex/) {
        $fail->{$_} = 1 unless $self->$_;
    }

    unless ($fail->{email}) {
        $self->email(Util::trim(lc $self->{email}));
        $fail->{email} = 1 if $self->email !~ /^.+@.+\.[a-z]{2,4}$/;
=c
        for my $class (USER_CLASSES) {
            # my $where = { email => $self->email };
            # if ($regcode) {
            #     $where->{regcode} = { 'ne' => $regcode };
            # }
            my @list = $class->list({ email => $self->email });
            if (@list) {
                $fail->{email} = $fail->{email_exist} = 1;
                last;
            }
        }
=cut
    }

    # my $fail = vars->{fail};
    # for (qw/class_number/) {
    #     $fail->{$_} = 1 unless $self->{$_};
    # }

    # unless ($fail->{class_number}) {
    #     $fail->{class_number} = 1 if $self->{class_number} !~ /^\d+$/ or $self->{class_number} < 1 or $self->{class_number} > 11;
    # }

    # var fail => $fail;

    unless ($fail->{fio}) {
        $fail->{fio} = 1 if length($self->fio) < 3;
    }

    unless ($fail->{password}) {
        $fail->{password} = 1 if $self->password !~ /^.{6,50}$/;
    }

    # $err->{code} = 1 if $form->{code};
    # delete $form->{code};

    var fail => $fail;
};

__PACKAGE__->meta->make_immutable();
