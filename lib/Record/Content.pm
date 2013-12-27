package Record::Content;

use Mouse;

use Errors;

extends 'Record';

has name  => (is => 'rw', isa => 'Str', required => 1,);
has descr => (is => 'rw', isa => 'Str', required => 1,);

sub add {
    my ($class, %params) = @_;

    my $self;
    if ($class->validate(\%params)) {
        $self = $class->new(%params);
        $self->insert;
    }
    return $self;
}

sub change {
    my ($self, %params) = @_;

    my $class = ref($self);
    if ($class->validate(\%params, { skip_empty => 1 })) {
        for my $k ($class->clear_params(\%params)) {
            $self->$k($params{$k});
        }
        $self->update;
    }
    return $self;
}

sub validate {
    my ($class, $params, $opt) = @_;
    $opt ||= {};

    unless ($opt->{skip_empty}) {
        for (qw/name descr/) {
            fail $_ unless $params->{$_} and length($params->{$_}) < 3;
        }
    }

    return failed() ? 0 : 1;
}

__PACKAGE__->meta->make_immutable();
