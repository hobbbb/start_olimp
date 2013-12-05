package Record::User;

use Util;
use Errors;

use Mouse;
use Mouse::Util::TypeConstraints;

extends 'Record';

has role => (
    is          => 'ro',
    isa         => enum([qw/admin student parent teacher/]),
    required    => 1,
);
has fio => (
    is          => 'rw',
    isa         => 'Str',
    required    => 1,
);
has email => (
    is          => 'ro',
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
    isa         => enum([qw/m f/]),
    required    => 1,
);
has class_number => (
    is          => 'rw',
    isa         => 'Str',
);
has school_number => (
    is          => 'rw',
    isa         => 'Str',
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
    required    => 1,
);
has x_real_ip   => (is => 'ro', isa => 'Any');
has last_visit  => (is => 'rw', isa => 'Any');

### Class methods

sub add {
    my ($class, %params) = @_;

    my $self;
    if ($class->validate(\%params)) {
        $self = $class->new(%params);
        $self->insert;
    }
    return $self;
}

sub check_auth {
    my ($class, $regcode) = @_;
    return unless $regcode;

    my $self = $class->list({ regcode => $regcode });

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

    # $self->last_visit(Util::now);

    return $self;
}

sub validate {
    my ($class, $params) = @_;

    for (qw/role fio email password sex/) {
        fail $_ unless $params->{$_};
    }

    unless (grep(/^$params->{role}$/, qw/student teacher parent/)) {
        fail 'role';
    }

    unless (fail 'fio') {
        fail 'fio' if length($params->{fio}) < 3;
    }

    unless (fail 'email') {
        # $params->{email} = Util::trim(lc $self->{email});
        fail 'email' if $params->{email} !~ /^.+@.+\.[a-z]{2,4}$/;

        # my $where = { email => $self->email };
        # if ($regcode) {
        #     $where->{regcode} = { 'ne' => $regcode };
        # }
        my @list = $class->list({ email => $params->{email} });
        if (@list) {
            fail 'email';
            fail 'email_exist';
        }
    }

    unless (fail 'password') {
        fail 'password' if $params->{password} !~ /^.{6,50}$/;
    }

    if ($params->{role} and $params->{role} eq 'student') {
        fail 'class_number' if !$params->{class_number} or $params->{class_number} !~ /^\d+$/ or $params->{class_number} < 1 or $params->{class_number} > 11;
    }
    if ($params->{role} and $params->{role} eq 'teacher') {
        fail 'school_number' unless $params->{school_number};
    }

    # fail 'code' if $params->{code};

    return fail() ? 0 : 1;
}

__PACKAGE__->meta->make_immutable();
