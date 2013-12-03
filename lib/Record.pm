package Record;

use Dancer ':syntax';
use Dancer::Plugin::Database;
use Carp;
use Util;

use Mouse;

has id  => (is => 'ro', isa => 'Int');

### Class methods

sub list {
    my ($class, $cond) = @_;
    $cond ||= {};

    my $list = [ database->quick_select($class->_tname, $cond) ];

    if (scalar @$list == 1) {
        return wantarray ? map { $class->new($_) } @$list : $class->new($list->[0]);
    }
    else {
        return map { $class->new($_) } @$list;
    }
}

sub count {
    my ($class, $cond) = @_;
    $cond ||= {};

    my $cnt = database->quick_count($class->_tname, $cond);
w $cnt;
    return $cnt;
}

sub get {
    my ($class, $id) = @_;

    my $row = database->quick_select($class->_tname, { id => $id }) or return;

    return $class->new($row);
}

### Object methods

sub insert {
    my $self = shift;
    return if vars->{fail};

    my $p = { %$self };
    database->quick_insert($self->_tname, $p) or return;
    $self->{id} = database->last_insert_id(undef, undef, undef, undef);

    return $self;
}

sub update {
    my $self = shift;
    croak 'no id' unless $self->{id};
    return if vars->{fail};

    my $p = { %$self };
    my $id = delete $p->{id};
    database->quick_update($self->_tname, { id => $id }, $p) or return;

    return $self;
}

### Other methods

sub delete {
    my $self = shift;
    croak 'no id' unless $self->{id};

    database->quick_delete($self->_tname, { id => $self->{id} }) or return;

    return 1;
}

sub as_vars {
    my $self = shift;
    return +{ %$self };
}

sub _tname {
    my ($invocant) = @_;
    my $name = ref($invocant) || $invocant;
    $name =~ s/^Record:://;
    $name =~ s/::/_/g;
    return $name;
}

__PACKAGE__->meta->make_immutable();
