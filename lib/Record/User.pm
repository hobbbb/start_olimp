package Record::User;

use Mouse;
use Mouse::Util::TypeConstraints;
use MouseX::NativeTraits;
use Digest::MD5 qw(md5_hex);

use Util;
use Errors;

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
    is          => 'ro',
    isa         => enum([qw/m f/]),
    required    => 1,
);
has class_number => (
    is          => 'rw',
    isa         => 'Maybe[Int]',
);
has school_number => (
    is          => 'rw',
    isa         => 'Maybe[Int]',
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

sub create {
    my ($class, %params) = @_;

    # TODO: protect from bots
    # fail 'code' if $params->{code};

    $params{password} = $class->password_crypt($params{password});

    return $class->_insert(%params);
}

sub save {
    my ($self, %params) = @_;

    $params{password} = ref($self)->password_crypt($params{password});
    delete $params{password} unless $params{password};

    return $self->_update(%params);
}

sub check_auth {
    my ($class, $regcode) = @_;
    return unless $regcode;

    my $self = $class->list({ regcode => $regcode }) or return;
    return $self->save(last_visit => Util::now);
}

sub get_by_login {
    my ($class, %params) = @_;
    my $password = $class->password_crypt($params{password}) or return;
    return $class->list({ email => $params{email}, password => $password });
}

sub password_crypt {
    my ($class, $password) = @_;
    return unless $password and length($password) >= 6;

    my $salt = '1b2r9';
    return $salt . md5_hex($salt . $password);
};

sub validate {
    my ($invocant, %args) = @_;
    my $class = ref($invocant) || $invocant;
    my %params = $invocant->merge_params(%args);

    for (qw/role fio email password sex/) {
        fail $_ unless $params{$_};
    }

    unless (grep(/^$params{role}$/, qw/student teacher parent/)) {
        fail 'role';
    }

    if ($params{fio}) {
        fail 'fio' if length($params{fio}) < 3;
    }

    if ($params{email}) {
        fail 'email' if $params{email} !~ /^.+@.+\.[a-z]{2,4}$/;
        if (!$params{id} and $class->list({ email => $params{email} })) {
            fail 'email';
            fail 'email_exist';
        }
    }

    if ($params{role} and $params{role} eq 'student') {
        fail 'class_number' if !$params{class_number} or $params{class_number} !~ /^\d+$/ or $params{class_number} < 1 or $params{class_number} > 11;
    }
    if ($params{role} and $params{role} eq 'teacher') {
        fail 'school_number' unless $params{school_number};
    }

    return failed() ? 0 : 1;
}

__PACKAGE__->meta->make_immutable();
