package Record;

use Mouse;

use Dancer ':syntax';
use Dancer::Plugin::Database;
use Util;

has id => (
    is      => 'ro',
    isa     => 'Int',
    clearer => 'clear_id',
);

### Class methods

sub take {
    my ($class, $id) = @_;

    my $row = database->quick_select($class->TABLE, { id => $id }) or return;

    return $class->new($row);
}

sub list {
    my ($class, $cond) = @_;
    $cond ||= {};

    my $list = [ database->quick_select($class->TABLE, $cond) ];

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

    return database->quick_count($class->TABLE, $cond);
}

### Object methods

sub insert {
    my $self = shift;
    $self->clear_id;

    my $p = { %$self };
    database->quick_insert($self->TABLE, $p) or return;
    $self->{id} = database->last_insert_id(undef, undef, undef, undef);

    return $self;
}

sub update {
    my $self = shift;
    confess('no id') unless $self->{id};

    my $p = { %$self };
    my $id = delete $p->{id};
    database->quick_update($self->TABLE, { id => $id }, $p) or return;

    return $self;
}

### Other methods

sub delete {
    my $self = shift;
    confess('no id') unless $self->{id};

    database->quick_delete($self->TABLE, { id => $self->{id} }) or return;

    return 1;
}

sub as_vars {
    my $self = shift;
    return +{ %$self };
}

sub TABLE {
    my ($invocant) = @_;
    my $name = ref($invocant) || $invocant;
    $name =~ s/^Record:://;
    $name =~ s/::/_/g;
    return $name;
}

__PACKAGE__->meta->make_immutable();
